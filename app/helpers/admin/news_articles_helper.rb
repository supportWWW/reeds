module Admin::NewsArticlesHelper

  def categories_select( form_helper )
    form_helper.select :category_id, Category.find( :all ).collect { |c| [c.name, c.id] }
  end

end
