# Extends the class object with class and instance accessors for class attributes, 
# just like the native attr* accessors for instance attributes.
#
# Copyright (c) 2005 Tobias Lutke
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
class Class # :nodoc:
  def cattr_reader(*syms)
    syms.each do |sym|
      class_eval <<-EOS
        if ! defined? @@#{sym.id2name}
          @@#{sym.id2name} = nil
        end
        
        def self.#{sym.id2name}
          @@#{sym}
        end

        def #{sym.id2name}
          @@#{sym}
        end

        def call_#{sym.id2name}
          case @@#{sym.id2name}
            when Symbol then send(@@#{sym})
            when Proc   then @@#{sym}.call(self)
            when String then @@#{sym}
            else nil
          end
        end
      EOS
    end
  end
  
  def cattr_writer(*syms)
    syms.each do |sym|
      class_eval <<-EOS
        if ! defined? @@#{sym.id2name}
          @@#{sym.id2name} = nil
        end
        
        def self.#{sym.id2name}=(obj)
          @@#{sym.id2name} = obj
        end

        def self.set_#{sym.id2name}(obj)
          @@#{sym.id2name} = obj
        end

        def #{sym.id2name}=(obj)
          @@#{sym} = obj
        end
      EOS
    end
  end
  
  def cattr_accessor(*syms)
    cattr_reader(*syms)
    cattr_writer(*syms)
  end
end