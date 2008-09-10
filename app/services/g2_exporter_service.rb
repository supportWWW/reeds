class G2ExporterService
  
  include Singleton
  
  def process()

    classifieds = Classified.available

    FasterCSV.generate do |csv|
      # header row
      csv << ["Date",
              "Mol Dealer",
              "Reg. No.",
              "MM Code",
              "Stock No.",
              "Colour",
              "Type",
              "Year",
              "Mileage",
              "Price",
              "Date In Stock",
              "Cost",
              "Stand in",
              "VIN",
              "Man Dealer",
              "Comments",
              "Condition",
              "Extra",
              "Trim",
              "IX Dealer",
              "IX Veh"]

      # data rows
      classifieds.each do |classified|
        csv << [Date.today,
                "",
                classified.reg_num,
                classified.model_variant.mead_mcgrouther_code,
                classified.stock_code,
                classified.colour,
                "GM_G2",
                classified.year,
                classified.mileage,
                classified.price,
                Date.today - (classified.days_in_stock).days,
                "",
                "",
                "",
                "",
                "",
                "Excellent",
                "",
                "",
                "",
                ""]
      end
    end

  end
  
end