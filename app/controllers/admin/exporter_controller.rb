class Admin::ExporterController < Admin::ApplicationController

  def export_g2
    respond_to do |format|
      format.html
      format.csv do
        csv_string = FasterCSV.generate do |csv|
          send_data G2ExporterService.instance.process,
                    :type => 'text/csv; charset=iso-8859-1; header=present',
                    :disposition => "attachment; filename=g2.csv"
        end

      end
    end
  end

  def export_autotrader
    respond_to do |format|
      format.html
      format.csv do
        csv_string = FasterCSV.generate do |csv|
          send_data AutoTraderExporterService.instance.process,
                    :type => 'text/csv; charset=iso-8859-1; header=present',
                    :disposition => "attachment; filename=autotrader.csv"
        end

      end
    end
  end

end
