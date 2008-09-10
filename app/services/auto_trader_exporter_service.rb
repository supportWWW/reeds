class AutoTraderExporterService
  
  include Singleton
  
  def process()

    classifieds = Classified.available

    FasterCSV.generate do |csv|
      # header row
      csv << ["",
              "CAT",
              "MAKE",
              "MODEL",
              "VARIANT",
              "DERIVATIVE",
              "REFERENCE",
              "FULLREG",
              "YEAR",
              "REGLET",
              "CUC",
              "PRICEPLAIN",
              "PRICEEXTRA",
              "TRADEPLAIN",
              "MILE",
              "MILEUNIT",
              "MOTUNT",
              "TRANSMISSION",
              "BODYTYPE",
              "DOORS",
              "FUEL",
              "COLOUR",
              "NAMCOL",
              "METALLICPAINT",
              "PREVIOUSOWNERS",
              "EXDEMO",
              "CC",
              "SMALLENGINESIZE",
              "LEARNER",
              "MAXWEIGHT",
              "MAXPULLINGWEIGHT",
              "AXLE",
              "CABTYPE",
              "BHP",
              "GTW",
              "",
              "FEAT",
              "ADDTEXT",
              "IMG1",
              "IMG2",
              "IMG3",
              "IMG4",
              "INSURANCEGROUP",
              "DATE OF REGISTRATION",
              "WEIGHTUNIT"]

      # data rows
      classifieds.each do |classified|
        if classified.make && classified.model
          csv << ["",
                  "CARS",
                  classified.make.name,
                  classified.model.name.split(" ").first,
                  "ANY (1980 - )",
                  classified.model.name.split(" ")[1..10].join(" "),
                  "",
                  classified.reg_num,
                  classified.year,
                  "",
                  "ZAR",
                  classified.price,
                  "",
                  "",
                  classified.mileage,
                  "k",
                  "",
                  "",
                  "",
                  "",
                  "",
                  classified.colour,
                  classified.colour,
                  "No",
                  0,
                  "No",
                  "",
                  "No",
                  "No",
                  "",
                  "",
                  "",
                  "",
                  0,
                  "",
                  "",
                  "",
                  "#{classified.year} #{classified.mileage}km #{classified.features}",
                  classified.img_url,
                  "",
                  "",
                  "",
                  "",
                  "",
                  "Kgs"]
        end
      end
    end

  end
  
end