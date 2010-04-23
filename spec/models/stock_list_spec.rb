require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StockList do

  it "should create stock list" do
    @classified_98 = mock_model(Classified)
    @classified_98.stub!(:humanize).and_return("Audi A4")
    @classified_98.stub!(:year).and_return("2008")
    @classified_98.stub!(:mileage).and_return(16000)
    @classified_98.stub!(:price).and_return(Money.new(25000000))
    @classified_99 = mock_model(Classified)
    @classified_99.stub!(:humanize).and_return("Opel Corsa")
    @classified_99.stub!(:year).and_return("2008")
    @classified_99.stub!(:mileage).and_return(8000)
    @classified_99.stub!(:price).and_return(Money.new(10000000))
    Classified.stub!(:find).and_return([@classified_98, @classified_99])
    StockList.stock.should == [@classified_98, @classified_99]
  end

  it "should send an email" do
    Mailbuild.stub!(:subscribers).and_return([{ :name => "Joerg", :email => "joergd@pobox.com" }])
    StockList.send.should
  end
  
end
