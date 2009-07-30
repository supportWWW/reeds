xml.root do
  @classifieds.each do |classified|
    xml.row do |row|
      row.Brand classified.make.name
      row.Model classified.model.common_name
      row.MMCode classified.model_variant.mead_mcgrouther_code
      row.Year classified.model_variant.year
      row.Mileage classified.mileage
      row.Price classified.price
      row.Thumb classified.full_img_url
      row.Pic classified.full_img_url
      row.Region "Western Cape"
      row.DealershipID (classified.branch.nil? ? "" : classified.branch.id)
      row.DealershipName (classified.branch.nil? ? "Reeds" : "Reeds " + classified.branch.name)
      row.Email "suzanned@reeds.co.za"
      row.PhoneNumber "021 443 5130"
      row.CellNumber ""
      row.ContactPerson "Suzanne Denicker"
      row.Colour classified.colour
      row.StockNo classified.stock_code
      row.NewUsed "Used"
      row.Comments ""
    end
  end
end
