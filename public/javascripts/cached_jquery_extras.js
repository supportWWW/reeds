/*
 * jQuery Form Plugin
 * version: 2.11 (05/26/2008)
 * @requires jQuery v1.2.2 or later
 *
 * Examples and documentation at: http://malsup.com/jquery/form/
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * Revision: $Id$
 */
(function($) {

/*
    Usage Note:  
    -----------
    Do not use both ajaxSubmit and ajaxForm on the same form.  These
    functions are intended to be exclusive.  Use ajaxSubmit if you want
    to bind your own submit handler to the form.  For example,

    $(document).ready(function() {
        $('#myForm').bind('submit', function() {
            $(this).ajaxSubmit({
                target: '#output'
            });
            return false; // <-- important!
        });
    });

    Use ajaxForm when you want the plugin to manage all the event binding
    for you.  For example,

    $(document).ready(function() {
        $('#myForm').ajaxForm({
            target: '#output'
        });
    });
        
    When using ajaxForm, the ajaxSubmit function will be invoked for you
    at the appropriate time.  
*/

/**
 * ajaxSubmit() provides a mechanism for immediately submitting 
 * an HTML form using AJAX.
 */
$.fn.ajaxSubmit = function(options) {
    // fast fail if nothing selected (http://dev.jquery.com/ticket/2752)
    if (!this.length) {
        log('ajaxSubmit: skipping submit process - no element selected');
        return this;
    }

    if (typeof options == 'function')
        options = { success: options };

    options = $.extend({
        url:  this.attr('action') || window.location.toString(),
        type: this.attr('method') || 'GET'
    }, options || {});

    // hook for manipulating the form data before it is extracted;
    // convenient for use with rich editors like tinyMCE or FCKEditor
    var veto = {};
    this.trigger('form-pre-serialize', [this, options, veto]);
    if (veto.veto) {
        log('ajaxSubmit: submit vetoed via form-pre-serialize trigger');
        return this;
   }

    var a = this.formToArray(options.semantic);
    if (options.data) {
        options.extraData = options.data;
        for (var n in options.data)
            a.push( { name: n, value: options.data[n] } );
    }

    // give pre-submit callback an opportunity to abort the submit
    if (options.beforeSubmit && options.beforeSubmit(a, this, options) === false) {
        log('ajaxSubmit: submit aborted via beforeSubmit callback');
        return this;
    }    

    // fire vetoable 'validate' event
    this.trigger('form-submit-validate', [a, this, options, veto]);
    if (veto.veto) {
        log('ajaxSubmit: submit vetoed via form-submit-validate trigger');
        return this;
    }    

    var q = $.param(a);

    if (options.type.toUpperCase() == 'GET') {
        options.url += (options.url.indexOf('?') >= 0 ? '&' : '?') + q;
        options.data = null;  // data is null for 'get'
    }
    else
        options.data = q; // data is the query string for 'post'

    var $form = this, callbacks = [];
    if (options.resetForm) callbacks.push(function() { $form.resetForm(); });
    if (options.clearForm) callbacks.push(function() { $form.clearForm(); });

    // perform a load on the target only if dataType is not provided
    if (!options.dataType && options.target) {
        var oldSuccess = options.success || function(){};
        callbacks.push(function(data) {
            $(options.target).html(data).each(oldSuccess, arguments);
        });
    }
    else if (options.success)
        callbacks.push(options.success);

    options.success = function(data, status) {
        for (var i=0, max=callbacks.length; i < max; i++)
            callbacks[i](data, status, $form);
    };

    // are there files to upload?
    var files = $('input:file', this).fieldValue();
    var found = false;
    for (var j=0; j < files.length; j++)
        if (files[j])
            found = true;

    // options.iframe allows user to force iframe mode
   if (options.iframe || found) { 
       // hack to fix Safari hang (thanks to Tim Molendijk for this)
       // see:  http://groups.google.com/group/jquery-dev/browse_thread/thread/36395b7ab510dd5d
       if ($.browser.safari && options.closeKeepAlive)
           $.get(options.closeKeepAlive, fileUpload);
       else
           fileUpload();
       }
   else
       $.ajax(options);

    // fire 'notify' event
    this.trigger('form-submit-notify', [this, options]);
    return this;


    // private function for handling file uploads (hat tip to YAHOO!)
    function fileUpload() {
        var form = $form[0];
        
        if ($(':input[@name=submit]', form).length) {
            alert('Error: Form elements must not be named "submit".');
            return;
        }
        
        var opts = $.extend({}, $.ajaxSettings, options);

        var id = 'jqFormIO' + (new Date().getTime());
        var $io = $('<iframe id="' + id + '" name="' + id + '" />');
        var io = $io[0];

        if ($.browser.msie || $.browser.opera) 
            io.src = 'javascript:false;document.write("");';
        $io.css({ position: 'absolute', top: '-1000px', left: '-1000px' });

        var xhr = { // mock object
            responseText: null,
            responseXML: null,
            status: 0,
            statusText: 'n/a',
            getAllResponseHeaders: function() {},
            getResponseHeader: function() {},
            setRequestHeader: function() {}
        };

        var g = opts.global;
        // trigger ajax global events so that activity/block indicators work like normal
        if (g && ! $.active++) $.event.trigger("ajaxStart");
        if (g) $.event.trigger("ajaxSend", [xhr, opts]);

        var cbInvoked = 0;
        var timedOut = 0;

        // take a breath so that pending repaints get some cpu time before the upload starts
        setTimeout(function() {
            // make sure form attrs are set
            var t = $form.attr('target'), a = $form.attr('action');
            $form.attr({
                target:   id,
                encoding: 'multipart/form-data',
                enctype:  'multipart/form-data',
                method:   'POST',
                action:   opts.url
            });

            // support timout
            if (opts.timeout)
                setTimeout(function() { timedOut = true; cb(); }, opts.timeout);

            // add "extra" data to form if provided in options
            var extraInputs = [];
            try {
                if (options.extraData)
                    for (var n in options.extraData)
                        extraInputs.push(
                            $('<input type="hidden" name="'+n+'" value="'+options.extraData[n]+'" />')
                                .appendTo(form)[0]);
            
                // add iframe to doc and submit the form
                $io.appendTo('body');
                io.attachEvent ? io.attachEvent('onload', cb) : io.addEventListener('load', cb, false);
                form.submit();
            }
            finally {
                // reset attrs and remove "extra" input elements
                $form.attr('action', a);
                t ? $form.attr('target', t) : $form.removeAttr('target');
                $(extraInputs).remove();
            }
        }, 10);

        function cb() {
            if (cbInvoked++) return;
            
            io.detachEvent ? io.detachEvent('onload', cb) : io.removeEventListener('load', cb, false);

            var operaHack = 0;
            var ok = true;
            try {
                if (timedOut) throw 'timeout';
                // extract the server response from the iframe
                var data, doc;

                doc = io.contentWindow ? io.contentWindow.document : io.contentDocument ? io.contentDocument : io.document;
                
                if (doc.body == null && !operaHack && $.browser.opera) {
                    // In Opera 9.2.x the iframe DOM is not always traversable when
                    // the onload callback fires so we give Opera 100ms to right itself
                    operaHack = 1;
                    cbInvoked--;
                    setTimeout(cb, 100);
                    return;
                }
                
                xhr.responseText = doc.body ? doc.body.innerHTML : null;
                xhr.responseXML = doc.XMLDocument ? doc.XMLDocument : doc;
                xhr.getResponseHeader = function(header){
                    var headers = {'content-type': opts.dataType};
                    return headers[header];
                };

                if (opts.dataType == 'json' || opts.dataType == 'script') {
                    var ta = doc.getElementsByTagName('textarea')[0];
                    xhr.responseText = ta ? ta.value : xhr.responseText;
                }
                else if (opts.dataType == 'xml' && !xhr.responseXML && xhr.responseText != null) {
                    xhr.responseXML = toXml(xhr.responseText);
                }
                data = $.httpData(xhr, opts.dataType);
            }
            catch(e){
                ok = false;
                $.handleError(opts, xhr, 'error', e);
            }

            // ordering of these callbacks/triggers is odd, but that's how $.ajax does it
            if (ok) {
                opts.success(data, 'success');
                if (g) $.event.trigger("ajaxSuccess", [xhr, opts]);
            }
            if (g) $.event.trigger("ajaxComplete", [xhr, opts]);
            if (g && ! --$.active) $.event.trigger("ajaxStop");
            if (opts.complete) opts.complete(xhr, ok ? 'success' : 'error');

            // clean up
            setTimeout(function() {
                $io.remove();
                xhr.responseXML = null;
            }, 100);
        };

        function toXml(s, doc) {
            if (window.ActiveXObject) {
                doc = new ActiveXObject('Microsoft.XMLDOM');
                doc.async = 'false';
                doc.loadXML(s);
            }
            else
                doc = (new DOMParser()).parseFromString(s, 'text/xml');
            return (doc && doc.documentElement && doc.documentElement.tagName != 'parsererror') ? doc : null;
        };
    };
};

/**
 * ajaxForm() provides a mechanism for fully automating form submission.
 *
 * The advantages of using this method instead of ajaxSubmit() are:
 *
 * 1: This method will include coordinates for <input type="image" /> elements (if the element
 *    is used to submit the form).
 * 2. This method will include the submit element's name/value data (for the element that was
 *    used to submit the form).
 * 3. This method binds the submit() method to the form for you.
 *
 * The options argument for ajaxForm works exactly as it does for ajaxSubmit.  ajaxForm merely
 * passes the options argument along after properly binding events for submit elements and
 * the form itself.
 */ 
$.fn.ajaxForm = function(options) {
    return this.ajaxFormUnbind().bind('submit.form-plugin',function() {
        $(this).ajaxSubmit(options);
        return false;
    }).each(function() {
        // store options in hash
        $(":submit,input:image", this).bind('click.form-plugin',function(e) {
            var $form = this.form;
            $form.clk = this;
            if (this.type == 'image') {
                if (e.offsetX != undefined) {
                    $form.clk_x = e.offsetX;
                    $form.clk_y = e.offsetY;
                } else if (typeof $.fn.offset == 'function') { // try to use dimensions plugin
                    var offset = $(this).offset();
                    $form.clk_x = e.pageX - offset.left;
                    $form.clk_y = e.pageY - offset.top;
                } else {
                    $form.clk_x = e.pageX - this.offsetLeft;
                    $form.clk_y = e.pageY - this.offsetTop;
                }
            }
            // clear form vars
            setTimeout(function() { $form.clk = $form.clk_x = $form.clk_y = null; }, 10);
        });
    });
};

// ajaxFormUnbind unbinds the event handlers that were bound by ajaxForm
$.fn.ajaxFormUnbind = function() {
    this.unbind('submit.form-plugin');
    return this.each(function() {
        $(":submit,input:image", this).unbind('click.form-plugin');
    });

};

/**
 * formToArray() gathers form element data into an array of objects that can
 * be passed to any of the following ajax functions: $.get, $.post, or load.
 * Each object in the array has both a 'name' and 'value' property.  An example of
 * an array for a simple login form might be:
 *
 * [ { name: 'username', value: 'jresig' }, { name: 'password', value: 'secret' } ]
 *
 * It is this array that is passed to pre-submit callback functions provided to the
 * ajaxSubmit() and ajaxForm() methods.
 */
$.fn.formToArray = function(semantic) {
    var a = [];
    if (this.length == 0) return a;

    var form = this[0];
    var els = semantic ? form.getElementsByTagName('*') : form.elements;
    if (!els) return a;
    for(var i=0, max=els.length; i < max; i++) {
        var el = els[i];
        var n = el.name;
        if (!n) continue;

        if (semantic && form.clk && el.type == "image") {
            // handle image inputs on the fly when semantic == true
            if(!el.disabled && form.clk == el)
                a.push({name: n+'.x', value: form.clk_x}, {name: n+'.y', value: form.clk_y});
            continue;
        }

        var v = $.fieldValue(el, true);
        if (v && v.constructor == Array) {
            for(var j=0, jmax=v.length; j < jmax; j++)
                a.push({name: n, value: v[j]});
        }
        else if (v !== null && typeof v != 'undefined')
            a.push({name: n, value: v});
    }

    if (!semantic && form.clk) {
        // input type=='image' are not found in elements array! handle them here
        var inputs = form.getElementsByTagName("input");
        for(var i=0, max=inputs.length; i < max; i++) {
            var input = inputs[i];
            var n = input.name;
            if(n && !input.disabled && input.type == "image" && form.clk == input)
                a.push({name: n+'.x', value: form.clk_x}, {name: n+'.y', value: form.clk_y});
        }
    }
    return a;
};

/**
 * Serializes form data into a 'submittable' string. This method will return a string
 * in the format: name1=value1&amp;name2=value2
 */
$.fn.formSerialize = function(semantic) {
    //hand off to jQuery.param for proper encoding
    return $.param(this.formToArray(semantic));
};

/**
 * Serializes all field elements in the jQuery object into a query string.
 * This method will return a string in the format: name1=value1&amp;name2=value2
 */
$.fn.fieldSerialize = function(successful) {
    var a = [];
    this.each(function() {
        var n = this.name;
        if (!n) return;
        var v = $.fieldValue(this, successful);
        if (v && v.constructor == Array) {
            for (var i=0,max=v.length; i < max; i++)
                a.push({name: n, value: v[i]});
        }
        else if (v !== null && typeof v != 'undefined')
            a.push({name: this.name, value: v});
    });
    //hand off to jQuery.param for proper encoding
    return $.param(a);
};

/**
 * Returns the value(s) of the element in the matched set.  For example, consider the following form:
 *
 *  <form><fieldset>
 *      <input name="A" type="text" />
 *      <input name="A" type="text" />
 *      <input name="B" type="checkbox" value="B1" />
 *      <input name="B" type="checkbox" value="B2"/>
 *      <input name="C" type="radio" value="C1" />
 *      <input name="C" type="radio" value="C2" />
 *  </fieldset></form>
 *
 *  var v = $(':text').fieldValue();
 *  // if no values are entered into the text inputs
 *  v == ['','']
 *  // if values entered into the text inputs are 'foo' and 'bar'
 *  v == ['foo','bar']
 *
 *  var v = $(':checkbox').fieldValue();
 *  // if neither checkbox is checked
 *  v === undefined
 *  // if both checkboxes are checked
 *  v == ['B1', 'B2']
 *
 *  var v = $(':radio').fieldValue();
 *  // if neither radio is checked
 *  v === undefined
 *  // if first radio is checked
 *  v == ['C1']
 *
 * The successful argument controls whether or not the field element must be 'successful'
 * (per http://www.w3.org/TR/html4/interact/forms.html#successful-controls).
 * The default value of the successful argument is true.  If this value is false the value(s)
 * for each element is returned.
 *
 * Note: This method *always* returns an array.  If no valid value can be determined the
 *       array will be empty, otherwise it will contain one or more values.
 */
$.fn.fieldValue = function(successful) {
    for (var val=[], i=0, max=this.length; i < max; i++) {
        var el = this[i];
        var v = $.fieldValue(el, successful);
        if (v === null || typeof v == 'undefined' || (v.constructor == Array && !v.length))
            continue;
        v.constructor == Array ? $.merge(val, v) : val.push(v);
    }
    return val;
};

/**
 * Returns the value of the field element.
 */
$.fieldValue = function(el, successful) {
    var n = el.name, t = el.type, tag = el.tagName.toLowerCase();
    if (typeof successful == 'undefined') successful = true;

    if (successful && (!n || el.disabled || t == 'reset' || t == 'button' ||
        (t == 'checkbox' || t == 'radio') && !el.checked ||
        (t == 'submit' || t == 'image') && el.form && el.form.clk != el ||
        tag == 'select' && el.selectedIndex == -1))
            return null;

    if (tag == 'select') {
        var index = el.selectedIndex;
        if (index < 0) return null;
        var a = [], ops = el.options;
        var one = (t == 'select-one');
        var max = (one ? index+1 : ops.length);
        for(var i=(one ? index : 0); i < max; i++) {
            var op = ops[i];
            if (op.selected) {
                // extra pain for IE...
                var v = $.browser.msie && !(op.attributes['value'].specified) ? op.text : op.value;
                if (one) return v;
                a.push(v);
            }
        }
        return a;
    }
    return el.value;
};

/**
 * Clears the form data.  Takes the following actions on the form's input fields:
 *  - input text fields will have their 'value' property set to the empty string
 *  - select elements will have their 'selectedIndex' property set to -1
 *  - checkbox and radio inputs will have their 'checked' property set to false
 *  - inputs of type submit, button, reset, and hidden will *not* be effected
 *  - button elements will *not* be effected
 */
$.fn.clearForm = function() {
    return this.each(function() {
        $('input,select,textarea', this).clearFields();
    });
};

/**
 * Clears the selected form elements.
 */
$.fn.clearFields = $.fn.clearInputs = function() {
    return this.each(function() {
        var t = this.type, tag = this.tagName.toLowerCase();
        if (t == 'text' || t == 'password' || tag == 'textarea')
            this.value = '';
        else if (t == 'checkbox' || t == 'radio')
            this.checked = false;
        else if (tag == 'select')
            this.selectedIndex = -1;
    });
};

/**
 * Resets the form data.  Causes all form elements to be reset to their original value.
 */
$.fn.resetForm = function() {
    return this.each(function() {
        // guard against an input with the name of 'reset'
        // note that IE reports the reset function as an 'object'
        if (typeof this.reset == 'function' || (typeof this.reset == 'object' && !this.reset.nodeType))
            this.reset();
    });
};

/**
 * Enables or disables any matching elements.
 */
$.fn.enable = function(b) { 
    if (b == undefined) b = true;
    return this.each(function() { 
        this.disabled = !b 
    });
};

/**
 * Checks/unchecks any matching checkboxes or radio buttons and
 * selects/deselects and matching option elements.
 */
$.fn.select = function(select) {
    if (select == undefined) select = true;
    return this.each(function() { 
        var t = this.type;
        if (t == 'checkbox' || t == 'radio')
            this.checked = select;
        else if (this.tagName.toLowerCase() == 'option') {
            var $sel = $(this).parent('select');
            if (select && $sel[0] && $sel[0].type == 'select-one') {
                // deselect all other options
                $sel.find('option').select(false);
            }
            this.selected = select;
        }
    });
};

// helper fn for console logging
// set $.fn.ajaxSubmit.debug to true to enable debug logging
function log() {
    if ($.fn.ajaxSubmit.debug && window.console && window.console.log)
        window.console.log('[jquery.form] ' + Array.prototype.join.call(arguments,''));
};

})(jQuery);

;(function($){$.ui={plugin:{add:function(module,option,set){var proto=$.ui[module].prototype;for(var i in set){proto.plugins[i]=proto.plugins[i]||[];proto.plugins[i].push([option,set[i]]);}},call:function(instance,name,args){var set=instance.plugins[name];if(!set){return;}
for(var i=0;i<set.length;i++){if(instance.options[set[i][0]]){set[i][1].apply(instance.element,args);}}}},cssCache:{},css:function(name){if($.ui.cssCache[name]){return $.ui.cssCache[name];}
var tmp=$('<div class="ui-resizable-gen">').addClass(name).css({position:'absolute',top:'-5000px',left:'-5000px',display:'block'}).appendTo('body');$.ui.cssCache[name]=!!((!(/auto|default/).test(tmp.css('cursor'))||(/^[1-9]/).test(tmp.css('height'))||(/^[1-9]/).test(tmp.css('width'))||!(/none/).test(tmp.css('backgroundImage'))||!(/transparent|rgba\(0, 0, 0, 0\)/).test(tmp.css('backgroundColor'))));try{$('body').get(0).removeChild(tmp.get(0));}catch(e){}
return $.ui.cssCache[name];},disableSelection:function(e){e.unselectable="on";e.onselectstart=function(){return false;};if(e.style){e.style.MozUserSelect="none";}},enableSelection:function(e){e.unselectable="off";e.onselectstart=function(){return true;};if(e.style){e.style.MozUserSelect="";}},hasScroll:function(e,a){var scroll=/top/.test(a||"top")?'scrollTop':'scrollLeft',has=false;if(e[scroll]>0)return true;e[scroll]=1;has=e[scroll]>0?true:false;e[scroll]=0;return has;}};var _remove=$.fn.remove;$.fn.remove=function(){$("*",this).add(this).trigger("remove");return _remove.apply(this,arguments);};function getter(namespace,plugin,method){var methods=$[namespace][plugin].getter||[];methods=(typeof methods=="string"?methods.split(/,?\s+/):methods);return($.inArray(method,methods)!=-1);}
var widgetPrototype={init:function(){},destroy:function(){this.element.removeData(this.widgetName);},getData:function(key){return this.options[key];},setData:function(key,value){this.options[key]=value;},enable:function(){this.setData('disabled',false);},disable:function(){this.setData('disabled',true);}};$.widget=function(name,prototype){var namespace=name.split(".")[0];name=name.split(".")[1];$.fn[name]=function(options){var isMethodCall=(typeof options=='string'),args=Array.prototype.slice.call(arguments,1);if(isMethodCall&&getter(namespace,name,options)){var instance=$.data(this[0],name);return(instance?instance[options].apply(instance,args):undefined);}
return this.each(function(){var instance=$.data(this,name);if(!instance){$.data(this,name,new $[namespace][name](this,options));}else if(isMethodCall){instance[options].apply(instance,args);}});};$[namespace][name]=function(element,options){var self=this;this.widgetName=name;this.options=$.extend({},$[namespace][name].defaults,options);this.element=$(element).bind('setData.'+name,function(e,key,value){return self.setData(key,value);}).bind('getData.'+name,function(e,key){return self.getData(key);}).bind('remove',function(){return self.destroy();});this.init();};$[namespace][name].prototype=$.extend({},widgetPrototype,prototype);};$.ui.mouse={mouseInit:function(){var self=this;this.element.bind('mousedown.'+this.widgetName,function(e){return self.mouseDown(e);});if($.browser.msie){this._mouseUnselectable=this.element.attr('unselectable');this.element.attr('unselectable','on');}
this.started=false;},mouseDestroy:function(){this.element.unbind('.'+this.widgetName);($.browser.msie&&this.element.attr('unselectable',this._mouseUnselectable));},mouseDown:function(e){(this._mouseStarted&&this.mouseUp(e));this._mouseDownEvent=e;var self=this,btnIsLeft=(e.which==1),elIsCancel=($(e.target).is(this.options.cancel));if(!btnIsLeft||elIsCancel){return true;}
this._mouseDelayMet=!this.options.delay;if(!this._mouseDelayMet){this._mouseDelayTimer=setTimeout(function(){self._mouseDelayMet=true;},this.options.delay);}
this._mouseMoveDelegate=function(e){return self.mouseMove(e);};this._mouseUpDelegate=function(e){return self.mouseUp(e);};$(document).bind('mousemove.'+this.widgetName,this._mouseMoveDelegate).bind('mouseup.'+this.widgetName,this._mouseUpDelegate);return false;},mouseMove:function(e){if($.browser.msie&&!e.button){return this.mouseUp(e);}
if(this._mouseStarted){this.mouseDrag(e);return false;}
if(this.mouseDistanceMet(e)&&this.mouseDelayMet(e)){this._mouseStarted=(this.mouseStart(this._mouseDownEvent,e)!==false);(this._mouseStarted||this.mouseUp(e));}
return!this._mouseStarted;},mouseUp:function(e){$(document).unbind('mousemove.'+this.widgetName,this._mouseMoveDelegate).unbind('mouseup.'+this.widgetName,this._mouseUpDelegate);if(this._mouseStarted){this._mouseStarted=false;this.mouseStop(e);}
return false;},mouseDistanceMet:function(e){return(Math.max(Math.abs(this._mouseDownEvent.pageX-e.pageX),Math.abs(this._mouseDownEvent.pageY-e.pageY))>=this.options.distance);},mouseDelayMet:function(e){return this._mouseDelayMet;},mouseStart:function(e){},mouseDrag:function(e){},mouseStop:function(e){}};$.ui.mouse.defaults={cancel:null,distance:0,delay:0};})(jQuery);;(function($){function Datepicker(){this.debug=false;this._nextId=0;this._inst=[];this._curInst=null;this._disabledInputs=[];this._datepickerShowing=false;this._inDialog=false;this.regional=[];this.regional['']={clearText:'Clear',clearStatus:'Erase the current date',closeText:'Close',closeStatus:'Close without change',prevText:'&#x3c;Prev',prevStatus:'Show the previous month',nextText:'Next&#x3e;',nextStatus:'Show the next month',currentText:'Today',currentStatus:'Show the current month',monthNames:['January','February','March','April','May','June','July','August','September','October','November','December'],monthNamesShort:['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],monthStatus:'Show a different month',yearStatus:'Show a different year',weekHeader:'Wk',weekStatus:'Week of the year',dayNames:['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],dayNamesShort:['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],dayNamesMin:['Su','Mo','Tu','We','Th','Fr','Sa'],dayStatus:'Set DD as first week day',dateStatus:'Select DD, M d',dateFormat:'mm/dd/yy',firstDay:0,initStatus:'Select a date',isRTL:false};this._defaults={showOn:'focus',showAnim:'show',defaultDate:null,appendText:'',buttonText:'...',buttonImage:'',buttonImageOnly:false,closeAtTop:true,mandatory:false,hideIfNoPrevNext:false,changeMonth:true,changeYear:true,yearRange:'-10:+10',changeFirstDay:true,showOtherMonths:false,showWeeks:false,calculateWeek:this.iso8601Week,shortYearCutoff:'+10',showStatus:false,statusForDate:this.dateStatus,minDate:null,maxDate:null,speed:'normal',beforeShowDay:null,beforeShow:null,onSelect:null,onClose:null,numberOfMonths:1,stepMonths:1,rangeSelect:false,rangeSeparator:' - '};$.extend(this._defaults,this.regional['']);this._datepickerDiv=$('<div id="ui-datepicker-div"></div>');}
$.extend(Datepicker.prototype,{markerClassName:'hasDatepicker',log:function(){if(this.debug)
console.log.apply('',arguments);},_register:function(inst){var id=this._nextId++;this._inst[id]=inst;return id;},_getInst:function(id){return this._inst[id]||id;},setDefaults:function(settings){extendRemove(this._defaults,settings||{});return this;},_attachDatepicker:function(target,settings){var inlineSettings=null;for(attrName in this._defaults){var attrValue=target.getAttribute('date:'+attrName);if(attrValue){inlineSettings=inlineSettings||{};try{inlineSettings[attrName]=eval(attrValue);}catch(err){inlineSettings[attrName]=attrValue;}}}
var nodeName=target.nodeName.toLowerCase();var instSettings=(inlineSettings?$.extend(settings||{},inlineSettings||{}):settings);if(nodeName=='input'){var inst=(inst&&!inlineSettings?inst:new DatepickerInstance(instSettings,false));this._connectDatepicker(target,inst);}else if(nodeName=='div'||nodeName=='span'){var inst=new DatepickerInstance(instSettings,true);this._inlineDatepicker(target,inst);}},_destroyDatepicker:function(target){var nodeName=target.nodeName.toLowerCase();var calId=target._calId;target._calId=null;var $target=$(target);if(nodeName=='input'){$target.siblings('.ui-datepicker-append').replaceWith('').end().siblings('.ui-datepicker-trigger').replaceWith('').end().removeClass(this.markerClassName).unbind('focus',this._showDatepicker).unbind('keydown',this._doKeyDown).unbind('keypress',this._doKeyPress);var wrapper=$target.parents('.ui-datepicker-wrap');if(wrapper)
wrapper.replaceWith(wrapper.html());}else if(nodeName=='div'||nodeName=='span')
$target.removeClass(this.markerClassName).empty();if($('input[_calId='+calId+']').length==0)
this._inst[calId]=null;},_enableDatepicker:function(target){target.disabled=false;$(target).siblings('button.ui-datepicker-trigger').each(function(){this.disabled=false;}).end().siblings('img.ui-datepicker-trigger').css({opacity:'1.0',cursor:''});this._disabledInputs=$.map(this._disabledInputs,function(value){return(value==target?null:value);});},_disableDatepicker:function(target){target.disabled=true;$(target).siblings('button.ui-datepicker-trigger').each(function(){this.disabled=true;}).end().siblings('img.ui-datepicker-trigger').css({opacity:'0.5',cursor:'default'});this._disabledInputs=$.map($.datepicker._disabledInputs,function(value){return(value==target?null:value);});this._disabledInputs[$.datepicker._disabledInputs.length]=target;},_isDisabledDatepicker:function(target){if(!target)
return false;for(var i=0;i<this._disabledInputs.length;i++){if(this._disabledInputs[i]==target)
return true;}
return false;},_changeDatepicker:function(target,name,value){var settings=name||{};if(typeof name=='string'){settings={};settings[name]=value;}
if(inst=this._getInst(target._calId)){extendRemove(inst._settings,settings);this._updateDatepicker(inst);}},_setDateDatepicker:function(target,date,endDate){if(inst=this._getInst(target._calId)){inst._setDate(date,endDate);this._updateDatepicker(inst);}},_getDateDatepicker:function(target){var inst=this._getInst(target._calId);if(inst){inst._setDateFromField($(target));}
return(inst?inst._getDate():null);},_doKeyDown:function(e){var inst=$.datepicker._getInst(this._calId);if($.datepicker._datepickerShowing)
switch(e.keyCode){case 9:$.datepicker._hideDatepicker(null,'');break;case 13:$.datepicker._selectDay(inst,inst._selectedMonth,inst._selectedYear,$('td.ui-datepicker-daysCellOver',inst._datepickerDiv)[0]);return false;break;case 27:$.datepicker._hideDatepicker(null,inst._get('speed'));break;case 33:$.datepicker._adjustDate(inst,(e.ctrlKey?-1:-inst._get('stepMonths')),(e.ctrlKey?'Y':'M'));break;case 34:$.datepicker._adjustDate(inst,(e.ctrlKey?+1:+inst._get('stepMonths')),(e.ctrlKey?'Y':'M'));break;case 35:if(e.ctrlKey)$.datepicker._clearDate(inst);break;case 36:if(e.ctrlKey)$.datepicker._gotoToday(inst);break;case 37:if(e.ctrlKey)$.datepicker._adjustDate(inst,-1,'D');break;case 38:if(e.ctrlKey)$.datepicker._adjustDate(inst,-7,'D');break;case 39:if(e.ctrlKey)$.datepicker._adjustDate(inst,+1,'D');break;case 40:if(e.ctrlKey)$.datepicker._adjustDate(inst,+7,'D');break;}
else if(e.keyCode==36&&e.ctrlKey)
$.datepicker._showDatepicker(this);},_doKeyPress:function(e){var inst=$.datepicker._getInst(this._calId);var chars=$.datepicker._possibleChars(inst._get('dateFormat'));var chr=String.fromCharCode(e.charCode==undefined?e.keyCode:e.charCode);return e.ctrlKey||(chr<' '||!chars||chars.indexOf(chr)>-1);},_connectDatepicker:function(target,inst){var input=$(target);if(input.is('.'+this.markerClassName))
return;var appendText=inst._get('appendText');var isRTL=inst._get('isRTL');if(appendText){if(isRTL)
input.before('<span class="ui-datepicker-append">'+appendText);else
input.after('<span class="ui-datepicker-append">'+appendText);}
var showOn=inst._get('showOn');if(showOn=='focus'||showOn=='both')
input.focus(this._showDatepicker);if(showOn=='button'||showOn=='both'){input.wrap('<span class="ui-datepicker-wrap">');var buttonText=inst._get('buttonText');var buttonImage=inst._get('buttonImage');var trigger=$(inst._get('buttonImageOnly')?$('<img>').addClass('ui-datepicker-trigger').attr({src:buttonImage,alt:buttonText,title:buttonText}):$('<button>').addClass('ui-datepicker-trigger').attr({type:'button'}).html(buttonImage!=''?$('<img>').attr({src:buttonImage,alt:buttonText,title:buttonText}):buttonText));if(isRTL)
input.before(trigger);else
input.after(trigger);trigger.click(function(){if($.datepicker._datepickerShowing&&$.datepicker._lastInput==target)
$.datepicker._hideDatepicker();else
$.datepicker._showDatepicker(target);});}
input.addClass(this.markerClassName).keydown(this._doKeyDown).keypress(this._doKeyPress).bind("setData.datepicker",function(event,key,value){inst._settings[key]=value;}).bind("getData.datepicker",function(event,key){return inst._get(key);});input[0]._calId=inst._id;},_inlineDatepicker:function(target,inst){var input=$(target);if(input.is('.'+this.markerClassName))
return;input.addClass(this.markerClassName).append(inst._datepickerDiv).bind("setData.datepicker",function(event,key,value){inst._settings[key]=value;}).bind("getData.datepicker",function(event,key){return inst._get(key);});input[0]._calId=inst._id;this._updateDatepicker(inst);},_inlineShow:function(inst){var numMonths=inst._getNumberOfMonths();inst._datepickerDiv.width(numMonths[1]*$('.ui-datepicker',inst._datepickerDiv[0]).width());},_dialogDatepicker:function(input,dateText,onSelect,settings,pos){var inst=this._dialogInst;if(!inst){inst=this._dialogInst=new DatepickerInstance({},false);this._dialogInput=$('<input type="text" size="1" style="position: absolute; top: -100px;"/>');this._dialogInput.keydown(this._doKeyDown);$('body').append(this._dialogInput);this._dialogInput[0]._calId=inst._id;}
extendRemove(inst._settings,settings||{});this._dialogInput.val(dateText);this._pos=(pos?(pos.length?pos:[pos.pageX,pos.pageY]):null);if(!this._pos){var browserWidth=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth;var browserHeight=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;var scrollX=document.documentElement.scrollLeft||document.body.scrollLeft;var scrollY=document.documentElement.scrollTop||document.body.scrollTop;this._pos=[(browserWidth/2)-100+scrollX,(browserHeight/2)-150+scrollY];}
this._dialogInput.css('left',this._pos[0]+'px').css('top',this._pos[1]+'px');inst._settings.onSelect=onSelect;this._inDialog=true;this._datepickerDiv.addClass('ui-datepicker-dialog');this._showDatepicker(this._dialogInput[0]);if($.blockUI)
$.blockUI(this._datepickerDiv);return this;},_showDatepicker:function(input){input=input.target||input;if(input.nodeName.toLowerCase()!='input')
input=$('input',input.parentNode)[0];if($.datepicker._isDisabledDatepicker(input)||$.datepicker._lastInput==input)
return;var inst=$.datepicker._getInst(input._calId);var beforeShow=inst._get('beforeShow');extendRemove(inst._settings,(beforeShow?beforeShow.apply(input,[input,inst]):{}));$.datepicker._hideDatepicker(null,'');$.datepicker._lastInput=input;inst._setDateFromField(input);if($.datepicker._inDialog)
input.value='';if(!$.datepicker._pos){$.datepicker._pos=$.datepicker._findPos(input);$.datepicker._pos[1]+=input.offsetHeight;}
var isFixed=false;$(input).parents().each(function(){isFixed|=$(this).css('position')=='fixed';});if(isFixed&&$.browser.opera){$.datepicker._pos[0]-=document.documentElement.scrollLeft;$.datepicker._pos[1]-=document.documentElement.scrollTop;}
inst._datepickerDiv.css('position',($.datepicker._inDialog&&$.blockUI?'static':(isFixed?'fixed':'absolute'))).css({left:$.datepicker._pos[0]+'px',top:$.datepicker._pos[1]+'px'});$.datepicker._pos=null;inst._rangeStart=null;$.datepicker._updateDatepicker(inst);if(!inst._inline){var speed=inst._get('speed');var postProcess=function(){$.datepicker._datepickerShowing=true;$.datepicker._afterShow(inst);};var showAnim=inst._get('showAnim')||'show';inst._datepickerDiv[showAnim](speed,postProcess);if(speed=='')
postProcess();if(inst._input[0].type!='hidden')
inst._input[0].focus();$.datepicker._curInst=inst;}},_updateDatepicker:function(inst){inst._datepickerDiv.empty().append(inst._generateDatepicker());var numMonths=inst._getNumberOfMonths();if(numMonths[0]!=1||numMonths[1]!=1)
inst._datepickerDiv.addClass('ui-datepicker-multi');else
inst._datepickerDiv.removeClass('ui-datepicker-multi');if(inst._get('isRTL'))
inst._datepickerDiv.addClass('ui-datepicker-rtl');else
inst._datepickerDiv.removeClass('ui-datepicker-rtl');if(inst._input&&inst._input[0].type!='hidden')
$(inst._input[0]).focus();},_afterShow:function(inst){var numMonths=inst._getNumberOfMonths();inst._datepickerDiv.width(numMonths[1]*$('.ui-datepicker',inst._datepickerDiv[0])[0].offsetWidth);if($.browser.msie&&parseInt($.browser.version)<7){$('iframe.ui-datepicker-cover').css({width:inst._datepickerDiv.width()+4,height:inst._datepickerDiv.height()+4});}
var isFixed=inst._datepickerDiv.css('position')=='fixed';var pos=inst._input?$.datepicker._findPos(inst._input[0]):null;var browserWidth=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth;var browserHeight=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;var scrollX=(isFixed?0:document.documentElement.scrollLeft||document.body.scrollLeft);var scrollY=(isFixed?0:document.documentElement.scrollTop||document.body.scrollTop);if((inst._datepickerDiv.offset().left+inst._datepickerDiv.width()-
(isFixed&&$.browser.msie?document.documentElement.scrollLeft:0))>(browserWidth+scrollX)){inst._datepickerDiv.css('left',Math.max(scrollX,pos[0]+(inst._input?$(inst._input[0]).width():null)-inst._datepickerDiv.width()-
(isFixed&&$.browser.opera?document.documentElement.scrollLeft:0))+'px');}
if((inst._datepickerDiv.offset().top+inst._datepickerDiv.height()-
(isFixed&&$.browser.msie?document.documentElement.scrollTop:0))>(browserHeight+scrollY)){inst._datepickerDiv.css('top',Math.max(scrollY,pos[1]-(this._inDialog?0:inst._datepickerDiv.height())-
(isFixed&&$.browser.opera?document.documentElement.scrollTop:0))+'px');}},_findPos:function(obj){while(obj&&(obj.type=='hidden'||obj.nodeType!=1)){obj=obj.nextSibling;}
var position=$(obj).offset();return[position.left,position.top];},_hideDatepicker:function(input,speed){var inst=this._curInst;if(!inst)
return;var rangeSelect=inst._get('rangeSelect');if(rangeSelect&&this._stayOpen){this._selectDate(inst,inst._formatDate(inst._currentDay,inst._currentMonth,inst._currentYear));}
this._stayOpen=false;if(this._datepickerShowing){speed=(speed!=null?speed:inst._get('speed'));var showAnim=inst._get('showAnim');inst._datepickerDiv[(showAnim=='slideDown'?'slideUp':(showAnim=='fadeIn'?'fadeOut':'hide'))](speed,function(){$.datepicker._tidyDialog(inst);});if(speed=='')
this._tidyDialog(inst);var onClose=inst._get('onClose');if(onClose){onClose.apply((inst._input?inst._input[0]:null),[inst._getDate(),inst]);}
this._datepickerShowing=false;this._lastInput=null;inst._settings.prompt=null;if(this._inDialog){this._dialogInput.css({position:'absolute',left:'0',top:'-100px'});if($.blockUI){$.unblockUI();$('body').append(this._datepickerDiv);}}
this._inDialog=false;}
this._curInst=null;},_tidyDialog:function(inst){inst._datepickerDiv.removeClass('ui-datepicker-dialog').unbind('.ui-datepicker');$('.ui-datepicker-prompt',inst._datepickerDiv).remove();},_checkExternalClick:function(event){if(!$.datepicker._curInst)
return;var $target=$(event.target);if(($target.parents("#ui-datepicker-div").length==0)&&!$target.hasClass('hasDatepicker')&&!$target.hasClass('ui-datepicker-trigger')&&$.datepicker._datepickerShowing&&!($.datepicker._inDialog&&$.blockUI)){$.datepicker._hideDatepicker(null,'');}},_adjustDate:function(id,offset,period){var inst=this._getInst(id);inst._adjustDate(offset,period);this._updateDatepicker(inst);},_gotoToday:function(id){var date=new Date();var inst=this._getInst(id);inst._selectedDay=date.getDate();inst._drawMonth=inst._selectedMonth=date.getMonth();inst._drawYear=inst._selectedYear=date.getFullYear();this._adjustDate(inst);},_selectMonthYear:function(id,select,period){var inst=this._getInst(id);inst._selectingMonthYear=false;inst[period=='M'?'_drawMonth':'_drawYear']=select.options[select.selectedIndex].value-0;this._adjustDate(inst);},_clickMonthYear:function(id){var inst=this._getInst(id);if(inst._input&&inst._selectingMonthYear&&!$.browser.msie)
inst._input[0].focus();inst._selectingMonthYear=!inst._selectingMonthYear;},_changeFirstDay:function(id,day){var inst=this._getInst(id);inst._settings.firstDay=day;this._updateDatepicker(inst);},_selectDay:function(id,month,year,td){if($(td).is('.ui-datepicker-unselectable'))
return;var inst=this._getInst(id);var rangeSelect=inst._get('rangeSelect');if(rangeSelect){if(!this._stayOpen){$('.ui-datepicker td').removeClass('ui-datepicker-currentDay');$(td).addClass('ui-datepicker-currentDay');}
this._stayOpen=!this._stayOpen;}
inst._selectedDay=inst._currentDay=$('a',td).html();inst._selectedMonth=inst._currentMonth=month;inst._selectedYear=inst._currentYear=year;this._selectDate(id,inst._formatDate(inst._currentDay,inst._currentMonth,inst._currentYear));if(this._stayOpen){inst._endDay=inst._endMonth=inst._endYear=null;inst._rangeStart=new Date(inst._currentYear,inst._currentMonth,inst._currentDay);this._updateDatepicker(inst);}
else if(rangeSelect){inst._endDay=inst._currentDay;inst._endMonth=inst._currentMonth;inst._endYear=inst._currentYear;inst._selectedDay=inst._currentDay=inst._rangeStart.getDate();inst._selectedMonth=inst._currentMonth=inst._rangeStart.getMonth();inst._selectedYear=inst._currentYear=inst._rangeStart.getFullYear();inst._rangeStart=null;if(inst._inline)
this._updateDatepicker(inst);}},_clearDate:function(id){var inst=this._getInst(id);if(inst._get('mandatory'))
return;this._stayOpen=false;inst._endDay=inst._endMonth=inst._endYear=inst._rangeStart=null;this._selectDate(inst,'');},_selectDate:function(id,dateStr){var inst=this._getInst(id);dateStr=(dateStr!=null?dateStr:inst._formatDate());if(inst._rangeStart)
dateStr=inst._formatDate(inst._rangeStart)+inst._get('rangeSeparator')+dateStr;if(inst._input)
inst._input.val(dateStr);var onSelect=inst._get('onSelect');if(onSelect)
onSelect.apply((inst._input?inst._input[0]:null),[dateStr,inst]);else if(inst._input)
inst._input.trigger('change');if(inst._inline)
this._updateDatepicker(inst);else if(!this._stayOpen){this._hideDatepicker(null,inst._get('speed'));this._lastInput=inst._input[0];if(typeof(inst._input[0])!='object')
inst._input[0].focus();this._lastInput=null;}},noWeekends:function(date){var day=date.getDay();return[(day>0&&day<6),''];},iso8601Week:function(date){var checkDate=new Date(date.getFullYear(),date.getMonth(),date.getDate(),(date.getTimezoneOffset()/-60));var firstMon=new Date(checkDate.getFullYear(),1-1,4);var firstDay=firstMon.getDay()||7;firstMon.setDate(firstMon.getDate()+1-firstDay);if(firstDay<4&&checkDate<firstMon){checkDate.setDate(checkDate.getDate()-3);return $.datepicker.iso8601Week(checkDate);}else if(checkDate>new Date(checkDate.getFullYear(),12-1,28)){firstDay=new Date(checkDate.getFullYear()+1,1-1,4).getDay()||7;if(firstDay>4&&(checkDate.getDay()||7)<firstDay-3){checkDate.setDate(checkDate.getDate()+3);return $.datepicker.iso8601Week(checkDate);}}
return Math.floor(((checkDate-firstMon)/86400000)/7)+1;},dateStatus:function(date,inst){return $.datepicker.formatDate(inst._get('dateStatus'),date,inst._getFormatConfig());},parseDate:function(format,value,settings){if(format==null||value==null)
throw'Invalid arguments';value=(typeof value=='object'?value.toString():value+'');if(value=='')
return null;var shortYearCutoff=(settings?settings.shortYearCutoff:null)||this._defaults.shortYearCutoff;var dayNamesShort=(settings?settings.dayNamesShort:null)||this._defaults.dayNamesShort;var dayNames=(settings?settings.dayNames:null)||this._defaults.dayNames;var monthNamesShort=(settings?settings.monthNamesShort:null)||this._defaults.monthNamesShort;var monthNames=(settings?settings.monthNames:null)||this._defaults.monthNames;var year=-1;var month=-1;var day=-1;var literal=false;var lookAhead=function(match){var matches=(iFormat+1<format.length&&format.charAt(iFormat+1)==match);if(matches)
iFormat++;return matches;};var getNumber=function(match){lookAhead(match);var size=(match=='y'?4:2);var num=0;while(size>0&&iValue<value.length&&value.charAt(iValue)>='0'&&value.charAt(iValue)<='9'){num=num*10+(value.charAt(iValue++)-0);size--;}
if(size==(match=='y'?4:2))
throw'Missing number at position '+iValue;return num;};var getName=function(match,shortNames,longNames){var names=(lookAhead(match)?longNames:shortNames);var size=0;for(var j=0;j<names.length;j++)
size=Math.max(size,names[j].length);var name='';var iInit=iValue;while(size>0&&iValue<value.length){name+=value.charAt(iValue++);for(var i=0;i<names.length;i++)
if(name==names[i])
return i+1;size--;}
throw'Unknown name at position '+iInit;};var checkLiteral=function(){if(value.charAt(iValue)!=format.charAt(iFormat))
throw'Unexpected literal at position '+iValue;iValue++;};var iValue=0;for(var iFormat=0;iFormat<format.length;iFormat++){if(literal)
if(format.charAt(iFormat)=="'"&&!lookAhead("'"))
literal=false;else
checkLiteral();else
switch(format.charAt(iFormat)){case'd':day=getNumber('d');break;case'D':getName('D',dayNamesShort,dayNames);break;case'm':month=getNumber('m');break;case'M':month=getName('M',monthNamesShort,monthNames);break;case'y':year=getNumber('y');break;case"'":if(lookAhead("'"))
checkLiteral();else
literal=true;break;default:checkLiteral();}}
if(year<100){year+=new Date().getFullYear()-new Date().getFullYear()%100+
(year<=shortYearCutoff?0:-100);}
var date=new Date(year,month-1,day);if(date.getFullYear()!=year||date.getMonth()+1!=month||date.getDate()!=day){throw'Invalid date';}
return date;},formatDate:function(format,date,settings){if(!date)
return'';var dayNamesShort=(settings?settings.dayNamesShort:null)||this._defaults.dayNamesShort;var dayNames=(settings?settings.dayNames:null)||this._defaults.dayNames;var monthNamesShort=(settings?settings.monthNamesShort:null)||this._defaults.monthNamesShort;var monthNames=(settings?settings.monthNames:null)||this._defaults.monthNames;var lookAhead=function(match){var matches=(iFormat+1<format.length&&format.charAt(iFormat+1)==match);if(matches)
iFormat++;return matches;};var formatNumber=function(match,value){return(lookAhead(match)&&value<10?'0':'')+value;};var formatName=function(match,value,shortNames,longNames){return(lookAhead(match)?longNames[value]:shortNames[value]);};var output='';var literal=false;if(date){for(var iFormat=0;iFormat<format.length;iFormat++){if(literal)
if(format.charAt(iFormat)=="'"&&!lookAhead("'"))
literal=false;else
output+=format.charAt(iFormat);else
switch(format.charAt(iFormat)){case'd':output+=formatNumber('d',date.getDate());break;case'D':output+=formatName('D',date.getDay(),dayNamesShort,dayNames);break;case'm':output+=formatNumber('m',date.getMonth()+1);break;case'M':output+=formatName('M',date.getMonth(),monthNamesShort,monthNames);break;case'y':output+=(lookAhead('y')?date.getFullYear():(date.getYear()%100<10?'0':'')+date.getYear()%100);break;case"'":if(lookAhead("'"))
output+="'";else
literal=true;break;default:output+=format.charAt(iFormat);}}}
return output;},_possibleChars:function(format){var chars='';var literal=false;for(var iFormat=0;iFormat<format.length;iFormat++)
if(literal)
if(format.charAt(iFormat)=="'"&&!lookAhead("'"))
literal=false;else
chars+=format.charAt(iFormat);else
switch(format.charAt(iFormat)){case'd'||'m'||'y':chars+='0123456789';break;case'D'||'M':return null;case"'":if(lookAhead("'"))
chars+="'";else
literal=true;break;default:chars+=format.charAt(iFormat);}
return chars;}});function DatepickerInstance(settings,inline){this._id=$.datepicker._register(this);this._selectedDay=0;this._selectedMonth=0;this._selectedYear=0;this._drawMonth=0;this._drawYear=0;this._input=null;this._inline=inline;this._datepickerDiv=(!inline?$.datepicker._datepickerDiv:$('<div id="ui-datepicker-div-'+this._id+'" class="ui-datepicker-inline">'));this._settings=extendRemove(settings||{});if(inline)
this._setDate(this._getDefaultDate());}
$.extend(DatepickerInstance.prototype,{_get:function(name){return this._settings[name]!==undefined?this._settings[name]:$.datepicker._defaults[name];},_setDateFromField:function(input){this._input=$(input);var dateFormat=this._get('dateFormat');var dates=this._input?this._input.val().split(this._get('rangeSeparator')):null;this._endDay=this._endMonth=this._endYear=null;var date=defaultDate=this._getDefaultDate();if(dates.length>0){var settings=this._getFormatConfig();if(dates.length>1){date=$.datepicker.parseDate(dateFormat,dates[1],settings)||defaultDate;this._endDay=date.getDate();this._endMonth=date.getMonth();this._endYear=date.getFullYear();}
try{date=$.datepicker.parseDate(dateFormat,dates[0],settings)||defaultDate;}catch(e){$.datepicker.log(e);date=defaultDate;}}
this._selectedDay=date.getDate();this._drawMonth=this._selectedMonth=date.getMonth();this._drawYear=this._selectedYear=date.getFullYear();this._currentDay=(dates[0]?date.getDate():0);this._currentMonth=(dates[0]?date.getMonth():0);this._currentYear=(dates[0]?date.getFullYear():0);this._adjustDate();},_getDefaultDate:function(){var date=this._determineDate('defaultDate',new Date());var minDate=this._getMinMaxDate('min',true);var maxDate=this._getMinMaxDate('max');date=(minDate&&date<minDate?minDate:date);date=(maxDate&&date>maxDate?maxDate:date);return date;},_determineDate:function(name,defaultDate){var offsetNumeric=function(offset){var date=new Date();date.setDate(date.getDate()+offset);return date;};var offsetString=function(offset,getDaysInMonth){var date=new Date();var matches=/^([+-]?[0-9]+)\s*(d|D|w|W|m|M|y|Y)?$/.exec(offset);if(matches){var year=date.getFullYear();var month=date.getMonth();var day=date.getDate();switch(matches[2]||'d'){case'd':case'D':day+=(matches[1]-0);break;case'w':case'W':day+=(matches[1]*7);break;case'm':case'M':month+=(matches[1]-0);day=Math.min(day,getDaysInMonth(year,month));break;case'y':case'Y':year+=(matches[1]-0);day=Math.min(day,getDaysInMonth(year,month));break;}
date=new Date(year,month,day);}
return date;};var date=this._get(name);return(date==null?defaultDate:(typeof date=='string'?offsetString(date,this._getDaysInMonth):(typeof date=='number'?offsetNumeric(date):date)));},_setDate:function(date,endDate){this._selectedDay=this._currentDay=date.getDate();this._drawMonth=this._selectedMonth=this._currentMonth=date.getMonth();this._drawYear=this._selectedYear=this._currentYear=date.getFullYear();if(this._get('rangeSelect')){if(endDate){this._endDay=endDate.getDate();this._endMonth=endDate.getMonth();this._endYear=endDate.getFullYear();}else{this._endDay=this._currentDay;this._endMonth=this._currentMonth;this._endYear=this._currentYear;}}
this._adjustDate();},_getDate:function(){var startDate=(!this._currentYear||(this._input&&this._input.val()=='')?null:new Date(this._currentYear,this._currentMonth,this._currentDay));if(this._get('rangeSelect')){return[startDate,(!this._endYear?null:new Date(this._endYear,this._endMonth,this._endDay))];}else
return startDate;},_generateDatepicker:function(){var today=new Date();today=new Date(today.getFullYear(),today.getMonth(),today.getDate());var showStatus=this._get('showStatus');var isRTL=this._get('isRTL');var clear=(this._get('mandatory')?'':'<div class="ui-datepicker-clear"><a onclick="jQuery.datepicker._clearDate('+this._id+');"'+
(showStatus?this._addStatus(this._get('clearStatus')||'&#xa0;'):'')+'>'+
this._get('clearText')+'</a></div>');var controls='<div class="ui-datepicker-control">'+(isRTL?'':clear)+'<div class="ui-datepicker-close"><a onclick="jQuery.datepicker._hideDatepicker();"'+
(showStatus?this._addStatus(this._get('closeStatus')||'&#xa0;'):'')+'>'+
this._get('closeText')+'</a></div>'+(isRTL?clear:'')+'</div>';var prompt=this._get('prompt');var closeAtTop=this._get('closeAtTop');var hideIfNoPrevNext=this._get('hideIfNoPrevNext');var numMonths=this._getNumberOfMonths();var stepMonths=this._get('stepMonths');var isMultiMonth=(numMonths[0]!=1||numMonths[1]!=1);var minDate=this._getMinMaxDate('min',true);var maxDate=this._getMinMaxDate('max');var drawMonth=this._drawMonth;var drawYear=this._drawYear;if(maxDate){var maxDraw=new Date(maxDate.getFullYear(),maxDate.getMonth()-numMonths[1]+1,maxDate.getDate());maxDraw=(minDate&&maxDraw<minDate?minDate:maxDraw);while(new Date(drawYear,drawMonth,1)>maxDraw){drawMonth--;if(drawMonth<0){drawMonth=11;drawYear--;}}}
var prev='<div class="ui-datepicker-prev">'+(this._canAdjustMonth(-1,drawYear,drawMonth)?'<a onclick="jQuery.datepicker._adjustDate('+this._id+', -'+stepMonths+', \'M\');"'+
(showStatus?this._addStatus(this._get('prevStatus')||'&#xa0;'):'')+'>'+
this._get('prevText')+'</a>':(hideIfNoPrevNext?'':'<label>'+this._get('prevText')+'</label>'))+'</div>';var next='<div class="ui-datepicker-next">'+(this._canAdjustMonth(+1,drawYear,drawMonth)?'<a onclick="jQuery.datepicker._adjustDate('+this._id+', +'+stepMonths+', \'M\');"'+
(showStatus?this._addStatus(this._get('nextStatus')||'&#xa0;'):'')+'>'+
this._get('nextText')+'</a>':(hideIfNoPrevNext?'>':'<label>'+this._get('nextText')+'</label>'))+'</div>';var html=(prompt?'<div class="ui-datepicker-prompt">'+prompt+'</div>':'')+
(closeAtTop&&!this._inline?controls:'')+'<div class="ui-datepicker-links">'+(isRTL?next:prev)+
(this._isInRange(today)?'<div class="ui-datepicker-current">'+'<a onclick="jQuery.datepicker._gotoToday('+this._id+');"'+
(showStatus?this._addStatus(this._get('currentStatus')||'&#xa0;'):'')+'>'+
this._get('currentText')+'</a></div>':'')+(isRTL?prev:next)+'</div>';var showWeeks=this._get('showWeeks');for(var row=0;row<numMonths[0];row++)
for(var col=0;col<numMonths[1];col++){var selectedDate=new Date(drawYear,drawMonth,this._selectedDay);html+='<div class="ui-datepicker-oneMonth'+(col==0?' ui-datepicker-newRow':'')+'">'+
this._generateMonthYearHeader(drawMonth,drawYear,minDate,maxDate,selectedDate,row>0||col>0)+'<table class="ui-datepicker" cellpadding="0" cellspacing="0"><thead>'+'<tr class="ui-datepicker-titleRow">'+
(showWeeks?'<td>'+this._get('weekHeader')+'</td>':'');var firstDay=this._get('firstDay');var changeFirstDay=this._get('changeFirstDay');var dayNames=this._get('dayNames');var dayNamesShort=this._get('dayNamesShort');var dayNamesMin=this._get('dayNamesMin');for(var dow=0;dow<7;dow++){var day=(dow+firstDay)%7;var status=this._get('dayStatus')||'&#xa0;';status=(status.indexOf('DD')>-1?status.replace(/DD/,dayNames[day]):status.replace(/D/,dayNamesShort[day]));html+='<td'+((dow+firstDay+6)%7>=5?' class="ui-datepicker-weekEndCell"':'')+'>'+
(!changeFirstDay?'<span':'<a onclick="jQuery.datepicker._changeFirstDay('+this._id+', '+day+');"')+
(showStatus?this._addStatus(status):'')+' title="'+dayNames[day]+'">'+
dayNamesMin[day]+(changeFirstDay?'</a>':'</span>')+'</td>';}
html+='</tr></thead><tbody>';var daysInMonth=this._getDaysInMonth(drawYear,drawMonth);if(drawYear==this._selectedYear&&drawMonth==this._selectedMonth){this._selectedDay=Math.min(this._selectedDay,daysInMonth);}
var leadDays=(this._getFirstDayOfMonth(drawYear,drawMonth)-firstDay+7)%7;var currentDate=(!this._currentDay?new Date(9999,9,9):new Date(this._currentYear,this._currentMonth,this._currentDay));var endDate=this._endDay?new Date(this._endYear,this._endMonth,this._endDay):currentDate;var printDate=new Date(drawYear,drawMonth,1-leadDays);var numRows=(isMultiMonth?6:Math.ceil((leadDays+daysInMonth)/7));var beforeShowDay=this._get('beforeShowDay');var showOtherMonths=this._get('showOtherMonths');var calculateWeek=this._get('calculateWeek')||$.datepicker.iso8601Week;var dateStatus=this._get('statusForDate')||$.datepicker.dateStatus;for(var dRow=0;dRow<numRows;dRow++){html+='<tr class="ui-datepicker-daysRow">'+
(showWeeks?'<td class="ui-datepicker-weekCol">'+calculateWeek(printDate)+'</td>':'');for(var dow=0;dow<7;dow++){var daySettings=(beforeShowDay?beforeShowDay.apply((this._input?this._input[0]:null),[printDate]):[true,'']);var otherMonth=(printDate.getMonth()!=drawMonth);var unselectable=otherMonth||!daySettings[0]||(minDate&&printDate<minDate)||(maxDate&&printDate>maxDate);html+='<td class="ui-datepicker-daysCell'+
((dow+firstDay+6)%7>=5?' ui-datepicker-weekEndCell':'')+
(otherMonth?' ui-datepicker-otherMonth':'')+
(printDate.getTime()==selectedDate.getTime()&&drawMonth==this._selectedMonth?' ui-datepicker-daysCellOver':'')+
(unselectable?' ui-datepicker-unselectable':'')+
(otherMonth&&!showOtherMonths?'':' '+daySettings[1]+
(printDate.getTime()>=currentDate.getTime()&&printDate.getTime()<=endDate.getTime()?' ui-datepicker-currentDay':'')+
(printDate.getTime()==today.getTime()?' ui-datepicker-today':''))+'"'+
(unselectable?'':' onmouseover="jQuery(this).addClass(\'ui-datepicker-daysCellOver\');'+
(!showStatus||(otherMonth&&!showOtherMonths)?'':'jQuery(\'#ui-datepicker-status-'+
this._id+'\').html(\''+(dateStatus.apply((this._input?this._input[0]:null),[printDate,this])||'&#xa0;')+'\');')+'"'+' onmouseout="jQuery(this).removeClass(\'ui-datepicker-daysCellOver\');'+
(!showStatus||(otherMonth&&!showOtherMonths)?'':'jQuery(\'#ui-datepicker-status-'+
this._id+'\').html(\'&#xa0;\');')+'" onclick="jQuery.datepicker._selectDay('+
this._id+','+drawMonth+','+drawYear+', this);"')+'>'+
(otherMonth?(showOtherMonths?printDate.getDate():'&#xa0;'):(unselectable?printDate.getDate():'<a>'+printDate.getDate()+'</a>'))+'</td>';printDate.setDate(printDate.getDate()+1);}
html+='</tr>';}
drawMonth++;if(drawMonth>11){drawMonth=0;drawYear++;}
html+='</tbody></table></div>';}
html+=(showStatus?'<div style="clear: both;"></div><div id="ui-datepicker-status-'+this._id+'" class="ui-datepicker-status">'+(this._get('initStatus')||'&#xa0;')+'</div>':'')+
(!closeAtTop&&!this._inline?controls:'')+'<div style="clear: both;"></div>'+
($.browser.msie&&parseInt($.browser.version)<7&&!this._inline?'<iframe src="javascript:false;" class="ui-datepicker-cover"></iframe>':'');return html;},_generateMonthYearHeader:function(drawMonth,drawYear,minDate,maxDate,selectedDate,secondary){minDate=(this._rangeStart&&minDate&&selectedDate<minDate?selectedDate:minDate);var showStatus=this._get('showStatus');var html='<div class="ui-datepicker-header">';var monthNames=this._get('monthNames');if(secondary||!this._get('changeMonth'))
html+=monthNames[drawMonth]+'&#xa0;';else{var inMinYear=(minDate&&minDate.getFullYear()==drawYear);var inMaxYear=(maxDate&&maxDate.getFullYear()==drawYear);html+='<select class="ui-datepicker-newMonth" '+'onchange="jQuery.datepicker._selectMonthYear('+this._id+', this, \'M\');" '+'onclick="jQuery.datepicker._clickMonthYear('+this._id+');"'+
(showStatus?this._addStatus(this._get('monthStatus')||'&#xa0;'):'')+'>';for(var month=0;month<12;month++){if((!inMinYear||month>=minDate.getMonth())&&(!inMaxYear||month<=maxDate.getMonth())){html+='<option value="'+month+'"'+
(month==drawMonth?' selected="selected"':'')+'>'+monthNames[month]+'</option>';}}
html+='</select>';}
if(secondary||!this._get('changeYear'))
html+=drawYear;else{var years=this._get('yearRange').split(':');var year=0;var endYear=0;if(years.length!=2){year=drawYear-10;endYear=drawYear+10;}else if(years[0].charAt(0)=='+'||years[0].charAt(0)=='-'){year=new Date().getFullYear()+parseInt(years[0],10);endYear=new Date().getFullYear()+parseInt(years[1],10);}else{year=parseInt(years[0],10);endYear=parseInt(years[1],10);}
year=(minDate?Math.max(year,minDate.getFullYear()):year);endYear=(maxDate?Math.min(endYear,maxDate.getFullYear()):endYear);html+='<select class="ui-datepicker-newYear" '+'onchange="jQuery.datepicker._selectMonthYear('+this._id+', this, \'Y\');" '+'onclick="jQuery.datepicker._clickMonthYear('+this._id+');"'+
(showStatus?this._addStatus(this._get('yearStatus')||'&#xa0;'):'')+'>';for(;year<=endYear;year++){html+='<option value="'+year+'"'+
(year==drawYear?' selected="selected"':'')+'>'+year+'</option>';}
html+='</select>';}
html+='</div>';return html;},_addStatus:function(text){return' onmouseover="jQuery(\'#ui-datepicker-status-'+this._id+'\').html(\''+text+'\');" '+'onmouseout="jQuery(\'#ui-datepicker-status-'+this._id+'\').html(\'&#xa0;\');"';},_adjustDate:function(offset,period){var year=this._drawYear+(period=='Y'?offset:0);var month=this._drawMonth+(period=='M'?offset:0);var day=Math.min(this._selectedDay,this._getDaysInMonth(year,month))+
(period=='D'?offset:0);var date=new Date(year,month,day);var minDate=this._getMinMaxDate('min',true);var maxDate=this._getMinMaxDate('max');date=(minDate&&date<minDate?minDate:date);date=(maxDate&&date>maxDate?maxDate:date);this._selectedDay=date.getDate();this._drawMonth=this._selectedMonth=date.getMonth();this._drawYear=this._selectedYear=date.getFullYear();},_getNumberOfMonths:function(){var numMonths=this._get('numberOfMonths');return(numMonths==null?[1,1]:(typeof numMonths=='number'?[1,numMonths]:numMonths));},_getMinMaxDate:function(minMax,checkRange){var date=this._determineDate(minMax+'Date',null);if(date){date.setHours(0);date.setMinutes(0);date.setSeconds(0);date.setMilliseconds(0);}
return date||(checkRange?this._rangeStart:null);},_getDaysInMonth:function(year,month){return 32-new Date(year,month,32).getDate();},_getFirstDayOfMonth:function(year,month){return new Date(year,month,1).getDay();},_canAdjustMonth:function(offset,curYear,curMonth){var numMonths=this._getNumberOfMonths();var date=new Date(curYear,curMonth+(offset<0?offset:numMonths[1]),1);if(offset<0)
date.setDate(this._getDaysInMonth(date.getFullYear(),date.getMonth()));return this._isInRange(date);},_isInRange:function(date){var newMinDate=(!this._rangeStart?null:new Date(this._selectedYear,this._selectedMonth,this._selectedDay));newMinDate=(newMinDate&&this._rangeStart<newMinDate?this._rangeStart:newMinDate);var minDate=newMinDate||this._getMinMaxDate('min');var maxDate=this._getMinMaxDate('max');return((!minDate||date>=minDate)&&(!maxDate||date<=maxDate));},_getFormatConfig:function(){var shortYearCutoff=this._get('shortYearCutoff');shortYearCutoff=(typeof shortYearCutoff!='string'?shortYearCutoff:new Date().getFullYear()%100+parseInt(shortYearCutoff,10));return{shortYearCutoff:shortYearCutoff,dayNamesShort:this._get('dayNamesShort'),dayNames:this._get('dayNames'),monthNamesShort:this._get('monthNamesShort'),monthNames:this._get('monthNames')};},_formatDate:function(day,month,year){if(!day){this._currentDay=this._selectedDay;this._currentMonth=this._selectedMonth;this._currentYear=this._selectedYear;}
var date=(day?(typeof day=='object'?day:new Date(year,month,day)):new Date(this._currentYear,this._currentMonth,this._currentDay));return $.datepicker.formatDate(this._get('dateFormat'),date,this._getFormatConfig());}});function extendRemove(target,props){$.extend(target,props);for(var name in props)
if(props[name]==null)
target[name]=null;return target;};$.fn.datepicker=function(options){var otherArgs=Array.prototype.slice.call(arguments,1);if(typeof options=='string'&&(options=='isDisabled'||options=='getDate')){return $.datepicker['_'+options+'Datepicker'].apply($.datepicker,[this[0]].concat(otherArgs));}
return this.each(function(){typeof options=='string'?$.datepicker['_'+options+'Datepicker'].apply($.datepicker,[this].concat(otherArgs)):$.datepicker._attachDatepicker(this,options);});};$.datepicker=new Datepicker();$(document).ready(function(){$(document.body).append($.datepicker._datepickerDiv).mousedown($.datepicker._checkExternalClick);});})(jQuery);;(function($){$.effects=$.effects||{};$.extend($.effects,{save:function(el,set){for(var i=0;i<set.length;i++){if(set[i]!==null)$.data(el[0],"ec.storage."+set[i],el[0].style[set[i]]);}},restore:function(el,set){for(var i=0;i<set.length;i++){if(set[i]!==null)el.css(set[i],$.data(el[0],"ec.storage."+set[i]));}},setMode:function(el,mode){if(mode=='toggle')mode=el.is(':hidden')?'show':'hide';return mode;},getBaseline:function(origin,original){var y,x;switch(origin[0]){case'top':y=0;break;case'middle':y=0.5;break;case'bottom':y=1;break;default:y=origin[0]/original.height;};switch(origin[1]){case'left':x=0;break;case'center':x=0.5;break;case'right':x=1;break;default:x=origin[1]/original.width;};return{x:x,y:y};},createWrapper:function(el){if(el.parent().attr('id')=='fxWrapper')
return el;var props={width:el.outerWidth({margin:true}),height:el.outerHeight({margin:true}),'float':el.css('float')};el.wrap('<div id="fxWrapper" style="font-size:100%;background:transparent;border:none;margin:0;padding:0"></div>');var wrapper=el.parent();if(el.css('position')=='static'){wrapper.css({position:'relative'});el.css({position:'relative'});}else{var top=parseInt(el.css('top'),10);if(isNaN(top))top='auto';var left=parseInt(el.css('left'),10);if(isNaN(top))left='auto';wrapper.css({position:el.css('position'),top:top,left:left,zIndex:el.css('z-index')}).show();el.css({position:'relative',top:0,left:0});}
wrapper.css(props);return wrapper;},removeWrapper:function(el){if(el.parent().attr('id')=='fxWrapper')
return el.parent().replaceWith(el);return el;},setTransition:function(el,list,factor,val){val=val||{};$.each(list,function(i,x){unit=el.cssUnit(x);if(unit[0]>0)val[x]=unit[0]*factor+unit[1];});return val;},animateClass:function(value,duration,easing,callback){var cb=(typeof easing=="function"?easing:(callback?callback:null));var ea=(typeof easing=="object"?easing:null);return this.each(function(){var offset={};var that=$(this);var oldStyleAttr=that.attr("style")||'';if(typeof oldStyleAttr=='object')oldStyleAttr=oldStyleAttr["cssText"];if(value.toggle){that.hasClass(value.toggle)?value.remove=value.toggle:value.add=value.toggle;}
var oldStyle=$.extend({},(document.defaultView?document.defaultView.getComputedStyle(this,null):this.currentStyle));if(value.add)that.addClass(value.add);if(value.remove)that.removeClass(value.remove);var newStyle=$.extend({},(document.defaultView?document.defaultView.getComputedStyle(this,null):this.currentStyle));if(value.add)that.removeClass(value.add);if(value.remove)that.addClass(value.remove);for(var n in newStyle){if(typeof newStyle[n]!="function"&&newStyle[n]&&n.indexOf("Moz")==-1&&n.indexOf("length")==-1&&newStyle[n]!=oldStyle[n]&&(n.match(/color/i)||(!n.match(/color/i)&&!isNaN(parseInt(newStyle[n],10))))&&(oldStyle.position!="static"||(oldStyle.position=="static"&&!n.match(/left|top|bottom|right/))))offset[n]=newStyle[n];}
that.animate(offset,duration,ea,function(){if(typeof $(this).attr("style")=='object'){$(this).attr("style")["cssText"]="";$(this).attr("style")["cssText"]=oldStyleAttr;}else $(this).attr("style",oldStyleAttr);if(value.add)$(this).addClass(value.add);if(value.remove)$(this).removeClass(value.remove);if(cb)cb.apply(this,arguments);});});}});$.fn.extend({_show:$.fn.show,_hide:$.fn.hide,__toggle:$.fn.toggle,_addClass:$.fn.addClass,_removeClass:$.fn.removeClass,_toggleClass:$.fn.toggleClass,effect:function(fx,o,speed,callback){return $.effects[fx]?$.effects[fx].call(this,{method:fx,options:o||{},duration:speed,callback:callback}):null;},show:function(){if(!arguments[0]||(arguments[0].constructor==Number||/(slow|normal|fast)/.test(arguments[0])))
return this._show.apply(this,arguments);else{var o=arguments[1]||{};o['mode']='show';return this.effect.apply(this,[arguments[0],o,arguments[2]||o.duration,arguments[3]||o.callback]);}},hide:function(){if(!arguments[0]||(arguments[0].constructor==Number||/(slow|normal|fast)/.test(arguments[0])))
return this._hide.apply(this,arguments);else{var o=arguments[1]||{};o['mode']='hide';return this.effect.apply(this,[arguments[0],o,arguments[2]||o.duration,arguments[3]||o.callback]);}},toggle:function(){if(!arguments[0]||(arguments[0].constructor==Number||/(slow|normal|fast)/.test(arguments[0]))||(arguments[0].constructor==Function))
return this.__toggle.apply(this,arguments);else{var o=arguments[1]||{};o['mode']='toggle';return this.effect.apply(this,[arguments[0],o,arguments[2]||o.duration,arguments[3]||o.callback]);}},addClass:function(classNames,speed,easing,callback){return speed?$.effects.animateClass.apply(this,[{add:classNames},speed,easing,callback]):this._addClass(classNames);},removeClass:function(classNames,speed,easing,callback){return speed?$.effects.animateClass.apply(this,[{remove:classNames},speed,easing,callback]):this._removeClass(classNames);},toggleClass:function(classNames,speed,easing,callback){return speed?$.effects.animateClass.apply(this,[{toggle:classNames},speed,easing,callback]):this._toggleClass(classNames);},morph:function(remove,add,speed,easing,callback){return $.effects.animateClass.apply(this,[{add:add,remove:remove},speed,easing,callback]);},switchClass:function(){return this.morph.apply(this,arguments);},cssUnit:function(key){var style=this.css(key),val=[];$.each(['em','px','%','pt'],function(i,unit){if(style.indexOf(unit)>0)
val=[parseFloat(style),unit];});return val;}});jQuery.each(['backgroundColor','borderBottomColor','borderLeftColor','borderRightColor','borderTopColor','color','outlineColor'],function(i,attr){jQuery.fx.step[attr]=function(fx){if(fx.state==0){fx.start=getColor(fx.elem,attr);fx.end=getRGB(fx.end);}
fx.elem.style[attr]="rgb("+[Math.max(Math.min(parseInt((fx.pos*(fx.end[0]-fx.start[0]))+fx.start[0]),255),0),Math.max(Math.min(parseInt((fx.pos*(fx.end[1]-fx.start[1]))+fx.start[1]),255),0),Math.max(Math.min(parseInt((fx.pos*(fx.end[2]-fx.start[2]))+fx.start[2]),255),0)].join(",")+")";}});function getRGB(color){var result;if(color&&color.constructor==Array&&color.length==3)
return color;if(result=/rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(color))
return[parseInt(result[1]),parseInt(result[2]),parseInt(result[3])];if(result=/rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(color))
return[parseFloat(result[1])*2.55,parseFloat(result[2])*2.55,parseFloat(result[3])*2.55];if(result=/#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(color))
return[parseInt(result[1],16),parseInt(result[2],16),parseInt(result[3],16)];if(result=/#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(color))
return[parseInt(result[1]+result[1],16),parseInt(result[2]+result[2],16),parseInt(result[3]+result[3],16)];if(result=/rgba\(0, 0, 0, 0\)/.exec(color))
return colors['transparent']
return colors[jQuery.trim(color).toLowerCase()];}
function getColor(elem,attr){var color;do{color=jQuery.curCSS(elem,attr);if(color!=''&&color!='transparent'||jQuery.nodeName(elem,"body"))
break;attr="backgroundColor";}while(elem=elem.parentNode);return getRGB(color);};var colors={aqua:[0,255,255],azure:[240,255,255],beige:[245,245,220],black:[0,0,0],blue:[0,0,255],brown:[165,42,42],cyan:[0,255,255],darkblue:[0,0,139],darkcyan:[0,139,139],darkgrey:[169,169,169],darkgreen:[0,100,0],darkkhaki:[189,183,107],darkmagenta:[139,0,139],darkolivegreen:[85,107,47],darkorange:[255,140,0],darkorchid:[153,50,204],darkred:[139,0,0],darksalmon:[233,150,122],darkviolet:[148,0,211],fuchsia:[255,0,255],gold:[255,215,0],green:[0,128,0],indigo:[75,0,130],khaki:[240,230,140],lightblue:[173,216,230],lightcyan:[224,255,255],lightgreen:[144,238,144],lightgrey:[211,211,211],lightpink:[255,182,193],lightyellow:[255,255,224],lime:[0,255,0],magenta:[255,0,255],maroon:[128,0,0],navy:[0,0,128],olive:[128,128,0],orange:[255,165,0],pink:[255,192,203],purple:[128,0,128],violet:[128,0,128],red:[255,0,0],silver:[192,192,192],white:[255,255,255],yellow:[255,255,0],transparent:[255,255,255]};jQuery.easing['jswing']=jQuery.easing['swing'];jQuery.extend(jQuery.easing,{def:'easeOutQuad',swing:function(x,t,b,c,d){return jQuery.easing[jQuery.easing.def](x,t,b,c,d);},easeInQuad:function(x,t,b,c,d){return c*(t/=d)*t+b;},easeOutQuad:function(x,t,b,c,d){return-c*(t/=d)*(t-2)+b;},easeInOutQuad:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t+b;return-c/2*((--t)*(t-2)-1)+b;},easeInCubic:function(x,t,b,c,d){return c*(t/=d)*t*t+b;},easeOutCubic:function(x,t,b,c,d){return c*((t=t/d-1)*t*t+1)+b;},easeInOutCubic:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t*t+b;return c/2*((t-=2)*t*t+2)+b;},easeInQuart:function(x,t,b,c,d){return c*(t/=d)*t*t*t+b;},easeOutQuart:function(x,t,b,c,d){return-c*((t=t/d-1)*t*t*t-1)+b;},easeInOutQuart:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t*t*t+b;return-c/2*((t-=2)*t*t*t-2)+b;},easeInQuint:function(x,t,b,c,d){return c*(t/=d)*t*t*t*t+b;},easeOutQuint:function(x,t,b,c,d){return c*((t=t/d-1)*t*t*t*t+1)+b;},easeInOutQuint:function(x,t,b,c,d){if((t/=d/2)<1)return c/2*t*t*t*t*t+b;return c/2*((t-=2)*t*t*t*t+2)+b;},easeInSine:function(x,t,b,c,d){return-c*Math.cos(t/d*(Math.PI/2))+c+b;},easeOutSine:function(x,t,b,c,d){return c*Math.sin(t/d*(Math.PI/2))+b;},easeInOutSine:function(x,t,b,c,d){return-c/2*(Math.cos(Math.PI*t/d)-1)+b;},easeInExpo:function(x,t,b,c,d){return(t==0)?b:c*Math.pow(2,10*(t/d-1))+b;},easeOutExpo:function(x,t,b,c,d){return(t==d)?b+c:c*(-Math.pow(2,-10*t/d)+1)+b;},easeInOutExpo:function(x,t,b,c,d){if(t==0)return b;if(t==d)return b+c;if((t/=d/2)<1)return c/2*Math.pow(2,10*(t-1))+b;return c/2*(-Math.pow(2,-10*--t)+2)+b;},easeInCirc:function(x,t,b,c,d){return-c*(Math.sqrt(1-(t/=d)*t)-1)+b;},easeOutCirc:function(x,t,b,c,d){return c*Math.sqrt(1-(t=t/d-1)*t)+b;},easeInOutCirc:function(x,t,b,c,d){if((t/=d/2)<1)return-c/2*(Math.sqrt(1-t*t)-1)+b;return c/2*(Math.sqrt(1-(t-=2)*t)+1)+b;},easeInElastic:function(x,t,b,c,d){var s=1.70158;var p=0;var a=c;if(t==0)return b;if((t/=d)==1)return b+c;if(!p)p=d*.3;if(a<Math.abs(c)){a=c;var s=p/4;}
else var s=p/(2*Math.PI)*Math.asin(c/a);return-(a*Math.pow(2,10*(t-=1))*Math.sin((t*d-s)*(2*Math.PI)/p))+b;},easeOutElastic:function(x,t,b,c,d){var s=1.70158;var p=0;var a=c;if(t==0)return b;if((t/=d)==1)return b+c;if(!p)p=d*.3;if(a<Math.abs(c)){a=c;var s=p/4;}
else var s=p/(2*Math.PI)*Math.asin(c/a);return a*Math.pow(2,-10*t)*Math.sin((t*d-s)*(2*Math.PI)/p)+c+b;},easeInOutElastic:function(x,t,b,c,d){var s=1.70158;var p=0;var a=c;if(t==0)return b;if((t/=d/2)==2)return b+c;if(!p)p=d*(.3*1.5);if(a<Math.abs(c)){a=c;var s=p/4;}
else var s=p/(2*Math.PI)*Math.asin(c/a);if(t<1)return-.5*(a*Math.pow(2,10*(t-=1))*Math.sin((t*d-s)*(2*Math.PI)/p))+b;return a*Math.pow(2,-10*(t-=1))*Math.sin((t*d-s)*(2*Math.PI)/p)*.5+c+b;},easeInBack:function(x,t,b,c,d,s){if(s==undefined)s=1.70158;return c*(t/=d)*t*((s+1)*t-s)+b;},easeOutBack:function(x,t,b,c,d,s){if(s==undefined)s=1.70158;return c*((t=t/d-1)*t*((s+1)*t+s)+1)+b;},easeInOutBack:function(x,t,b,c,d,s){if(s==undefined)s=1.70158;if((t/=d/2)<1)return c/2*(t*t*(((s*=(1.525))+1)*t-s))+b;return c/2*((t-=2)*t*(((s*=(1.525))+1)*t+s)+2)+b;},easeInBounce:function(x,t,b,c,d){return c-jQuery.easing.easeOutBounce(x,d-t,0,c,d)+b;},easeOutBounce:function(x,t,b,c,d){if((t/=d)<(1/2.75)){return c*(7.5625*t*t)+b;}else if(t<(2/2.75)){return c*(7.5625*(t-=(1.5/2.75))*t+.75)+b;}else if(t<(2.5/2.75)){return c*(7.5625*(t-=(2.25/2.75))*t+.9375)+b;}else{return c*(7.5625*(t-=(2.625/2.75))*t+.984375)+b;}},easeInOutBounce:function(x,t,b,c,d){if(t<d/2)return jQuery.easing.easeInBounce(x,t*2,0,c,d)*.5+b;return jQuery.easing.easeOutBounce(x,t*2-d,0,c,d)*.5+c*.5+b;}});})(jQuery);;(function($){$.effects.highlight=function(o){return this.queue(function(){var el=$(this),props=['backgroundImage','backgroundColor','opacity'];var mode=$.effects.setMode(el,o.options.mode||'show');var color=o.options.color||"#ffff99";var oldColor=el.css("backgroundColor");$.effects.save(el,props);el.show();el.css({backgroundImage:'none',backgroundColor:color});var animation={backgroundColor:oldColor};if(mode=="hide")animation['opacity']=0;el.animate(animation,{queue:false,duration:o.duration,easing:o.options.easing,complete:function(){if(mode=="hide")el.hide();$.effects.restore(el,props);if(mode=="show"&&jQuery.browser.msie)this.style.removeAttribute('filter');if(o.callback)o.callback.apply(this,arguments);el.dequeue();}});});};})(jQuery);

$(function(){jQuery.highlight=document.body.createTextRange?function(a,b){var r=document.body.createTextRange();r.moveToElementText(a);for(var i=0;r.findText(b);i++){r.pasteHTML('<span class="highlight">'+r.text+'<\/span>');r.collapse(false)}}:function(a,b){var c,skip,spannode,middlebit,endbit,middleclone;skip=0;if(a.nodeType==3){c=a.data.toUpperCase().indexOf(b);if(c>=0){spannode=document.createElement('span');spannode.className='highlight';middlebit=a.splitText(c);endbit=middlebit.splitText(b.length);middleclone=middlebit.cloneNode(true);spannode.appendChild(middleclone);middlebit.parentNode.replaceChild(spannode,middlebit);skip=1}}else if(a.nodeType==1&&a.childNodes&&!/(script|style)/i.test(a.tagName)){for(var i=0;i<a.childNodes.length;++i){i+=$.highlight(a.childNodes[i],b)}}return skip}});jQuery.fn.removeHighlight=function(){this.find("span.highlight").each(function(){with(this.parentNode){replaceChild(this.firstChild,this);normalize()}});return this};

/* * jQuery UI Accordion 1.6 *  * Copyright (c) 2007 Jörn Zaefferer * * http://docs.jquery.com/UI/Accordion * * Dual licensed under the MIT and GPL licenses: *   http://www.opensource.org/licenses/mit-license.php *   http://www.gnu.org/licenses/gpl.html * * Revision: $Id: jquery.accordion.js 4876 2008-03-08 11:49:04Z joern.zaefferer $ * */;(function($) {	// If the UI scope is not available, add it$.ui = $.ui || {};$.fn.extend({	accordion: function(options, data) {		var args = Array.prototype.slice.call(arguments, 1);		return this.each(function() {			if (typeof options == "string") {				var accordion = $.data(this, "ui-accordion");				accordion[options].apply(accordion, args);			// INIT with optional options			} else if (!$(this).is(".ui-accordion"))				$.data(this, "ui-accordion", new $.ui.accordion(this, options));		});	},	// deprecated, use accordion("activate", index) instead	activate: function(index) {		return this.accordion("activate", index);	}});$.ui.accordion = function(container, options) {		// setup configuration	this.options = options = $.extend({}, $.ui.accordion.defaults, options);	this.element = container;		$(container).addClass("ui-accordion");		if ( options.navigation ) {		var current = $(container).find("a").filter(options.navigationFilter);		if ( current.length ) {			if ( current.filter(options.header).length ) {				options.active = current;			} else {				options.active = current.parent().parent().prev();				current.addClass("current");			}		}	}		// calculate active if not specified, using the first header	options.headers = $(container).find(options.header);	options.active = findActive(options.headers, options.active);	if ( options.fillSpace ) {		var maxHeight = $(container).parent().height();		options.headers.each(function() {			maxHeight -= $(this).outerHeight();		});		var maxPadding = 0;		options.headers.next().each(function() {			maxPadding = Math.max(maxPadding, $(this).innerHeight() - $(this).height());		}).height(maxHeight - maxPadding);	} else if ( options.autoheight ) {		var maxHeight = 0;		options.headers.next().each(function() {			maxHeight = Math.max(maxHeight, $(this).outerHeight());		}).height(maxHeight);	}	options.headers		.not(options.active || "")		.next()		.hide();	options.active.parent().andSelf().addClass(options.selectedClass);		if (options.event)		$(container).bind((options.event) + ".ui-accordion", clickHandler);};$.ui.accordion.prototype = {	activate: function(index) {		// call clickHandler with custom event		clickHandler.call(this.element, {			target: findActive( this.options.headers, index )[0]		});	},		enable: function() {		this.options.disabled = false;	},	disable: function() {		this.options.disabled = true;	},	destroy: function() {		this.options.headers.next().css("display", "");		if ( this.options.fillSpace || this.options.autoheight ) {			this.options.headers.next().css("height", "");		}		$.removeData(this.element, "ui-accordion");		$(this.element).removeClass("ui-accordion").unbind(".ui-accordion");	}}function scopeCallback(callback, scope) {	return function() {		return callback.apply(scope, arguments);	};}function completed(cancel) {	// if removed while animated data can be empty	if (!$.data(this, "ui-accordion"))		return;	var instance = $.data(this, "ui-accordion");	var options = instance.options;	options.running = cancel ? 0 : --options.running;	if ( options.running )		return;	if ( options.clearStyle ) {		options.toShow.add(options.toHide).css({			height: "",			overflow: ""		});	}	$(this).triggerHandler("change.ui-accordion", [options.data], options.change);}function toggle(toShow, toHide, data, clickedActive, down) {	var options = $.data(this, "ui-accordion").options;	options.toShow = toShow;	options.toHide = toHide;	options.data = data;	var complete = scopeCallback(completed, this);		// count elements to animate	options.running = toHide.size() == 0 ? toShow.size() : toHide.size();		if ( options.animated ) {		if ( !options.alwaysOpen && clickedActive ) {			$.ui.accordion.animations[options.animated]({				toShow: jQuery([]),				toHide: toHide,				complete: complete,				down: down,				autoheight: options.autoheight			});		} else {			$.ui.accordion.animations[options.animated]({				toShow: toShow,				toHide: toHide,				complete: complete,				down: down,				autoheight: options.autoheight			});		}	} else {		if ( !options.alwaysOpen && clickedActive ) {			toShow.toggle();		} else {			toHide.hide();			toShow.show();		}		complete(true);	}}function clickHandler(event) {	var options = $.data(this, "ui-accordion").options;	if (options.disabled)		return false;		// called only when using activate(false) to close all parts programmatically	if ( !event.target && !options.alwaysOpen ) {		options.active.parent().andSelf().toggleClass(options.selectedClass);		var toHide = options.active.next(),			data = {				instance: this,				options: options,				newHeader: jQuery([]),				oldHeader: options.active,				newContent: jQuery([]),				oldContent: toHide			},			toShow = options.active = $([]);		toggle.call(this, toShow, toHide, data );		return false;	}	// get the click target	var clicked = $(event.target);		// due to the event delegation model, we have to check if one	// of the parent elements is our actual header, and find that	if ( clicked.parents(options.header).length )		while ( !clicked.is(options.header) )			clicked = clicked.parent();		var clickedActive = clicked[0] == options.active[0];		// if animations are still active, or the active header is the target, ignore click	if (options.running || (options.alwaysOpen && clickedActive))		return false;	if (!clicked.is(options.header))		return;	// switch classes	options.active.parent().andSelf().toggleClass(options.selectedClass);	if ( !clickedActive ) {		clicked.parent().andSelf().addClass(options.selectedClass);	}	// find elements to show and hide	var toShow = clicked.next(),		toHide = options.active.next(),		//data = [clicked, options.active, toShow, toHide],		data = {			instance: this,			options: options,			newHeader: clicked,			oldHeader: options.active,			newContent: toShow,			oldContent: toHide		},		down = options.headers.index( options.active[0] ) > options.headers.index( clicked[0] );		options.active = clickedActive ? $([]) : clicked;	toggle.call(this, toShow, toHide, data, clickedActive, down );	return false;};function findActive(headers, selector) {	return selector != undefined		? typeof selector == "number"			? headers.filter(":eq(" + selector + ")")			: headers.not(headers.not(selector))		: selector === false			? $([])			: headers.filter(":eq(0)");}$.extend($.ui.accordion, {	defaults: {		selectedClass: "selected",		alwaysOpen: true,		animated: 'slide',		event: "click",		header: "a",		autoheight: true,		running: 0,		navigationFilter: function() {			return this.href.toLowerCase() == location.href.toLowerCase();		}	},	animations: {		slide: function(options, additions) {			options = $.extend({				easing: "swing",				duration: 300			}, options, additions);			if ( !options.toHide.size() ) {				options.toShow.animate({height: "show"}, options);				return;			}			var hideHeight = options.toHide.height(),				showHeight = options.toShow.height(),				difference = showHeight / hideHeight;			options.toShow.css({ height: 0, overflow: 'hidden' }).show();			options.toHide.filter(":hidden").each(options.complete).end().filter(":visible").animate({height:"hide"},{				step: function(now) {					var current = (hideHeight - now) * difference;					if ($.browser.msie || $.browser.opera) {						current = Math.ceil(current);					}					options.toShow.height( current );				},				duration: options.duration,				easing: options.easing,				complete: function() {					if ( !options.autoheight ) {						options.toShow.css("height", "auto");					}					options.complete();				}			});		},		bounceslide: function(options) {			this.slide(options, {				easing: options.down ? "bounceout" : "swing",				duration: options.down ? 1000 : 200			});		},		easeslide: function(options) {			this.slide(options, {				easing: "easeinout",				duration: 700			})		}	}});})(jQuery);

/* * jQuery Cycle Plugin for light-weight slideshows * Examples and documentation at: http://malsup.com/jquery/cycle/ * Copyright (c) 2007-2008 M. Alsup * Version: 2.22 (06/08/2008) * Dual licensed under the MIT and GPL licenses: * http://www.opensource.org/licenses/mit-license.php * http://www.gnu.org/licenses/gpl.html * Requires: jQuery v1.1.3.1 or later * * Based on the work of: *  1) Matt Oakes (http://portfolio.gizone.co.uk/applications/slideshow/) *  2) Torsten Baldes (http://medienfreunde.com/lab/innerfade/) *  3) Benjamin Sterling (http://www.benjaminsterling.com/experiments/jqShuffle/) */(function($) {var ver = '2.22';var ie6 = $.browser.msie && /MSIE 6.0/.test(navigator.userAgent);function log() {    if (window.console && window.console.log)        window.console.log('[cycle] ' + Array.prototype.join.call(arguments,''));};$.fn.cycle = function(options) {    return this.each(function() {        options = options || {};        if (options.constructor == String) {            switch(options) {            case 'stop':                if (this.cycleTimeout) clearTimeout(this.cycleTimeout);                this.cycleTimeout = 0;                return;            case 'pause':                this.cyclePause = 1;                return;            case 'resume':                this.cyclePause = 0;                return;            default:                options = { fx: options };            };        }        // stop existing slideshow for this container (if there is one)        if (this.cycleTimeout) clearTimeout(this.cycleTimeout);        this.cycleTimeout = 0;        this.cyclePause = 0;        var $cont = $(this);        var $slides = options.slideExpr ? $(options.slideExpr, this) : $cont.children();        var els = $slides.get();        if (els.length < 2) {            log('terminating; too few slides: ' + els.length);            return; // don't bother        }        // support metadata plugin (v1.0 and v2.0)        var opts = $.extend({}, $.fn.cycle.defaults, options || {}, $.metadata ? $cont.metadata() : $.meta ? $cont.data() : {});        if (opts.autostop)            opts.countdown = opts.autostopCount || els.length;        opts.before = opts.before ? [opts.before] : [];        opts.after = opts.after ? [opts.after] : [];        opts.after.unshift(function(){ opts.busy=0; });        if (opts.continuous)            opts.after.push(function() { go(els,opts,0,!opts.rev); });        // clearType corrections        if (ie6 && opts.cleartype && !opts.cleartypeNoBg)            clearTypeFix($slides);        // allow shorthand overrides of width, height and timeout        var cls = this.className;        opts.width = parseInt((cls.match(/w:(\d+)/)||[])[1]) || opts.width;        opts.height = parseInt((cls.match(/h:(\d+)/)||[])[1]) || opts.height;        opts.timeout = parseInt((cls.match(/t:(\d+)/)||[])[1]) || opts.timeout;        if ($cont.css('position') == 'static')            $cont.css('position', 'relative');        if (opts.width)            $cont.width(opts.width);        if (opts.height && opts.height != 'auto')            $cont.height(opts.height);        if (opts.random) {            opts.randomMap = [];            for (var i = 0; i < els.length; i++)                opts.randomMap.push(i);            opts.randomMap.sort(function(a,b) {return Math.random() - 0.5;});            opts.randomIndex = 0;            opts.startingSlide = opts.randomMap[0];        }        else if (opts.startingSlide >= els.length)            opts.startingSlide = 0; // catch bogus input        var first = opts.startingSlide || 0;        $slides.css({position: 'absolute', top:0, left:0}).hide().each(function(i) {            var z = first ? i >= first ? els.length - (i-first) : first-i : els.length-i;            $(this).css('z-index', z)        });        $(els[first]).css('opacity',1).show(); // opacity bit needed to handle reinit case        if ($.browser.msie) els[first].style.removeAttribute('filter');        if (opts.fit && opts.width)            $slides.width(opts.width);        if (opts.fit && opts.height && opts.height != 'auto')            $slides.height(opts.height);        if (opts.pause)            $cont.hover(function(){this.cyclePause=1;}, function(){this.cyclePause=0;});        // run transition init fn        var init = $.fn.cycle.transitions[opts.fx];        if ($.isFunction(init))            init($cont, $slides, opts);        else if (opts.fx != 'custom')            log('unknown transition: ' + opts.fx);        $slides.each(function() {            var $el = $(this);            this.cycleH = (opts.fit && opts.height) ? opts.height : $el.height();            this.cycleW = (opts.fit && opts.width) ? opts.width : $el.width();        });        opts.cssBefore = opts.cssBefore || {};        opts.animIn = opts.animIn || {};        opts.animOut = opts.animOut || {};        $slides.not(':eq('+first+')').css(opts.cssBefore);        if (opts.cssFirst)            $($slides[first]).css(opts.cssFirst);        if (opts.timeout) {            // ensure that timeout and speed settings are sane            if (opts.speed.constructor == String)                opts.speed = {slow: 600, fast: 200}[opts.speed] || 400;            if (!opts.sync)                opts.speed = opts.speed / 2;            while((opts.timeout - opts.speed) < 250)                opts.timeout += opts.speed;        }        if (opts.easing)            opts.easeIn = opts.easeOut = opts.easing;        if (!opts.speedIn)            opts.speedIn = opts.speed;        if (!opts.speedOut)            opts.speedOut = opts.speed; 		opts.slideCount = els.length;        opts.currSlide = first;        if (opts.random) {            opts.nextSlide = opts.currSlide;            if (++opts.randomIndex == els.length)                opts.randomIndex = 0;            opts.nextSlide = opts.randomMap[opts.randomIndex];        }        else            opts.nextSlide = opts.startingSlide >= (els.length-1) ? 0 : opts.startingSlide+1;        // fire artificial events        var e0 = $slides[first];        if (opts.before.length)            opts.before[0].apply(e0, [e0, e0, opts, true]);        if (opts.after.length > 1)            opts.after[1].apply(e0, [e0, e0, opts, true]);        if (opts.click && !opts.next)            opts.next = opts.click;        if (opts.next)            $(opts.next).bind('click', function(){return advance(els,opts,opts.rev?-1:1)});        if (opts.prev)            $(opts.prev).bind('click', function(){return advance(els,opts,opts.rev?1:-1)});        if (opts.pager)            buildPager(els,opts);        // expose fn for adding slides after the show has started        opts.addSlide = function(newSlide) {            var $s = $(newSlide), s = $s[0];            if (!opts.autostopCount)                opts.countdown++;            els.push(s);            if (opts.els)                opts.els.push(s); // shuffle needs this            opts.slideCount = els.length;            $s.css('position','absolute').appendTo($cont);            if (ie6 && opts.cleartype && !opts.cleartypeNoBg)                clearTypeFix($s);            if (opts.fit && opts.width)                $s.width(opts.width);            if (opts.fit && opts.height && opts.height != 'auto')                $slides.height(opts.height);            s.cycleH = (opts.fit && opts.height) ? opts.height : $s.height();            s.cycleW = (opts.fit && opts.width) ? opts.width : $s.width();            $s.css(opts.cssBefore);            if (typeof opts.onAddSlide == 'function')                opts.onAddSlide($s);        };        if (opts.timeout || opts.continuous)            this.cycleTimeout = setTimeout(                function(){go(els,opts,0,!opts.rev)},                opts.continuous ? 10 : opts.timeout + (opts.delay||0));    });};function go(els, opts, manual, fwd) {    if (opts.busy) return;    var p = els[0].parentNode, curr = els[opts.currSlide], next = els[opts.nextSlide];    if (p.cycleTimeout === 0 && !manual)        return;    if (!manual && !p.cyclePause &&        ((opts.autostop && (--opts.countdown <= 0)) ||        (opts.nowrap && !opts.random && opts.nextSlide < opts.currSlide))) {        if (opts.end)            opts.end(opts);        return;    }    if (manual || !p.cyclePause) {        if (opts.before.length)            $.each(opts.before, function(i,o) { o.apply(next, [curr, next, opts, fwd]); });        var after = function() {            if ($.browser.msie && opts.cleartype)                this.style.removeAttribute('filter');            $.each(opts.after, function(i,o) { o.apply(next, [curr, next, opts, fwd]); });        };        if (opts.nextSlide != opts.currSlide) {            opts.busy = 1;            if (opts.fxFn)                opts.fxFn(curr, next, opts, after, fwd);            else if ($.isFunction($.fn.cycle[opts.fx]))                $.fn.cycle[opts.fx](curr, next, opts, after);            else                $.fn.cycle.custom(curr, next, opts, after);        }        if (opts.random) {            opts.currSlide = opts.nextSlide;            if (++opts.randomIndex == els.length)                opts.randomIndex = 0;            opts.nextSlide = opts.randomMap[opts.randomIndex];        }        else { // sequence            var roll = (opts.nextSlide + 1) == els.length;            opts.nextSlide = roll ? 0 : opts.nextSlide+1;            opts.currSlide = roll ? els.length-1 : opts.nextSlide-1;        }        if (opts.pager)            $.fn.cycle.updateActivePagerLink(opts.pager, opts.currSlide);    }    if (opts.timeout && !opts.continuous)        p.cycleTimeout = setTimeout(function() { go(els,opts,0,!opts.rev) }, opts.timeout);    else if (opts.continuous && p.cyclePause)        p.cycleTimeout = setTimeout(function() { go(els,opts,0,!opts.rev) }, 10);};$.fn.cycle.updateActivePagerLink = function(pager, currSlide) {    $(pager).find('a').removeClass('activeSlide').filter('a:eq('+currSlide+')').addClass('activeSlide');};// advance slide forward or backfunction advance(els, opts, val) {    var p = els[0].parentNode, timeout = p.cycleTimeout;    if (timeout) {        clearTimeout(timeout);        p.cycleTimeout = 0;    }    opts.nextSlide = opts.currSlide + val;    if (opts.nextSlide < 0) {        if (opts.nowrap) return false;        opts.nextSlide = els.length - 1;    }    else if (opts.nextSlide >= els.length) {        if (opts.nowrap) return false;        opts.nextSlide = 0;    }    if (opts.prevNextClick && typeof opts.prevNextClick == 'function')        opts.prevNextClick(val > 0, opts.nextSlide, els[opts.nextSlide]);    go(els, opts, 1, val>=0);    return false;};function buildPager(els, opts) {    var $p = $(opts.pager);    $.each(els, function(i,o) {        var $a = (typeof opts.pagerAnchorBuilder == 'function')            ? $(opts.pagerAnchorBuilder(i,o))            : $('<a href="#">'+(i+1)+'</a>');        // don't reparent if anchor is in the dom        if ($a.parents('body').length == 0)            $a.appendTo($p);        $a.bind(opts.pagerEvent, function() {            opts.nextSlide = i;            var p = els[0].parentNode, timeout = p.cycleTimeout;            if (timeout) {                clearTimeout(timeout);                p.cycleTimeout = 0;            }            if (typeof opts.pagerClick == 'function')                opts.pagerClick(opts.nextSlide, els[opts.nextSlide]);            go(els,opts,1,!opts.rev);            return false;        });    });   //$p.find('a').filter('a:eq('+opts.startingSlide+')').addClass('activeSlide');   $.fn.cycle.updateActivePagerLink(opts.pager, opts.startingSlide);};// this fixes clearType problems in ie6 by setting an explicit bg colorfunction clearTypeFix($slides) {    function hex(s) {        var s = parseInt(s).toString(16);        return s.length < 2 ? '0'+s : s;    };    function getBg(e) {        for ( ; e && e.nodeName.toLowerCase() != 'html'; e = e.parentNode) {            var v = $.css(e,'background-color');            if (v.indexOf('rgb') >= 0 ) {                var rgb = v.match(/\d+/g);                return '#'+ hex(rgb[0]) + hex(rgb[1]) + hex(rgb[2]);            }            if (v && v != 'transparent')                return v;        }        return '#ffffff';    };    $slides.each(function() { $(this).css('background-color', getBg(this)); });};$.fn.cycle.custom = function(curr, next, opts, cb) {    var $l = $(curr), $n = $(next);    $n.css(opts.cssBefore);    var fn = function() {$n.animate(opts.animIn, opts.speedIn, opts.easeIn, cb)};    $l.animate(opts.animOut, opts.speedOut, opts.easeOut, function() {        if (opts.cssAfter) $l.css(opts.cssAfter);        if (!opts.sync) fn();    });    if (opts.sync) fn();};$.fn.cycle.transitions = {    fade: function($cont, $slides, opts) {        $slides.not(':eq('+opts.startingSlide+')').css('opacity',0);        opts.before.push(function() { $(this).show() });        opts.animIn    = { opacity: 1 };        opts.animOut   = { opacity: 0 };        opts.cssBefore = { opacity: 0 };        opts.cssAfter  = { display: 'none' };    }};$.fn.cycle.ver = function() { return ver; };// override these globally if you like (they are all optional)$.fn.cycle.defaults = {    fx:           'scollLeft', // one of: fade, shuffle, zoom, scrollLeft, etc    timeout:       4000,  // milliseconds between slide transitions (0 to disable auto advance)    continuous:    0,     // true to start next transition immediately after current one completes    speed:         800,  // speed of the transition (any valid fx speed value)    speedIn:       null,  // speed of the 'in' transition    speedOut:      null,  // speed of the 'out' transition    next:          null,  // id of element to use as click trigger for next slide    prev:          null,  // id of element to use as click trigger for previous slide    prevNextClick: null,  // callback fn for prev/next clicks:  function(isNext, zeroBasedSlideIndex, slideElement)    pager:         null,  // id of element to use as pager container    pagerClick:    null,  // callback fn for pager clicks:  function(zeroBasedSlideIndex, slideElement)    pagerEvent:   'click', // event which drives the pager navigation    pagerAnchorBuilder: null, // callback fn for building anchor links    before:        null,  // transition callback (scope set to element to be shown)    after:         null,  // transition callback (scope set to element that was shown)    end:           null,  // callback invoked when the slideshow terminates (use with autostop or nowrap options)    easing:        null,  // easing method for both in and out transitions    easeIn:        null,  // easing for "in" transition    easeOut:       null,  // easing for "out" transition    shuffle:       null,  // coords for shuffle animation, ex: { top:15, left: 200 }    animIn:        null,  // properties that define how the slide animates in    animOut:       null,  // properties that define how the slide animates out    cssBefore:     null,  // properties that define the initial state of the slide before transitioning in    cssAfter:      null,  // properties that defined the state of the slide after transitioning out    fxFn:          null,  // function used to control the transition    height:       'auto', // container height    startingSlide: 0,     // zero-based index of the first slide to be displayed    sync:          1,     // true if in/out transitions should occur simultaneously    random:        0,     // true for random, false for sequence (not applicable to shuffle fx)    fit:           0,     // force slides to fit container    pause:         1,     // true to enable "pause on hover"    autostop:      0,     // true to end slideshow after X transitions (where X == slide count)    autostopCount: 0,     // number of transitions (optionally used with autostop to define X)    delay:         0,     // additional delay (in ms) for first transition (hint: can be negative)    slideExpr:     null,  // expression for selecting slides (if something other than all children is required)    cleartype:     0,     // true if clearType corrections should be applied (for IE)    nowrap:        0      // true to prevent slideshow from wrapping};})(jQuery);/* * jQuery Cycle Plugin Transition Definitions * This script is a plugin for the jQuery Cycle Plugin * Examples and documentation at: http://malsup.com/jquery/cycle/ * Copyright (c) 2007-2008 M. Alsup * Version:  2.22 * Dual licensed under the MIT and GPL licenses: * http://www.opensource.org/licenses/mit-license.php * http://www.gnu.org/licenses/gpl.html */(function($) {//// These functions define one-time slide initialization for the named// transitions. To save file size feel free to remove any of these that you// don't need.//// scrollLeft/Right$.fn.cycle.transitions.scrollLeft = function($cont, $slides, opts) {    $cont.css('overflow','hidden');    opts.before.push(function(curr, next, opts) {        $(this).show();        opts.cssBefore.left = next.offsetWidth;        opts.animOut.left = 0-curr.offsetWidth;    });    opts.cssFirst = { left: 0 };    opts.animIn   = { left: 0 };};$.fn.cycle.transitions.scrollRight = function($cont, $slides, opts) {    $cont.css('overflow','hidden');    opts.before.push(function(curr, next, opts) {        $(this).show();        opts.cssBefore.left = 0-next.offsetWidth;        opts.animOut.left = curr.offsetWidth;    });    opts.cssFirst = { left: 0 };    opts.animIn   = { left: 0 };};$.fn.cycle.transitions.scrollHorz = function($cont, $slides, opts) {    $cont.css('overflow','hidden').width();//    $slides.show();    opts.before.push(function(curr, next, opts, fwd) {        $(this).show();        var currW = curr.offsetWidth, nextW = next.offsetWidth;        opts.cssBefore = fwd ? { left: nextW } : { left: -nextW };        opts.animIn.left = 0;        opts.animOut.left = fwd ? -currW : currW;        $slides.not(curr).css(opts.cssBefore);    });    opts.cssFirst = { left: 0 };    opts.cssAfter = { display: 'none' }};})(jQuery);

		jQuery().ready(function(){			jQuery('#serviceContent').accordion({			autoheight: false			});		});					// Cycle		$(function() {			$('#fW_Content').cycle({ 			fx:    'scrollLeft',			pager: '#fW_Controls' 			});		});				// Open Blank Window		$(function(){			$('a.viewWebsite').click(function(){				window.open(this.href);				return false;			});		});				// Smooth Scrolling		$(document).ready(function(){			$('a[href*=#]').click(function() {				if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'')				&& location.hostname == this.hostname) {					var $target = $(this.hash);					$target = $target.length && $target					|| $('[name=' + this.hash.slice(1) +']');					if ($target.length) {						var targetOffset = $target.offset().top;						$('html,body')						.animate({scrollTop: targetOffset}, 300);					return false;					}				}			});		});

sfHover = function() {	var sfEls = document.getElementById("nav").getElementsByTagName("LI");	for (var i=0; i<sfEls.length; i++) {		sfEls[i].onmouseover=function() {			this.className+="sfhover";		}		sfEls[i].onmouseout=function() {			this.className=this.className.replace(new RegExp("sfhover\\b"), "");		}	}}if (window.attachEvent) window.attachEvent("onload", sfHover);