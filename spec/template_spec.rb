require 'text-invoice'

describe TextInvoice::Template do
    it "should return invoice html the using default template" do
        template = TextInvoice::Template.new
        invoice = YAML.load(TextInvoice::Invoice.blank)
        invoice["invoice"] = "123"
        
        html = template.html(invoice.to_yaml)
       
        # check for something from the template
        html.should include("html")
        # check for something from the data
        html.should include("123")
    end
    
    it "should return invoice html the using a custom template" do
        template = TextInvoice::Template.new
        invoice = YAML.load(TextInvoice::Invoice.blank)
        invoice["invoice"] = "123"

        html = template.custom(invoice.to_yaml, "templates/invoice.html")
        
        # check for something from the template
        html.should include("html")
        # check for something from the data
        html.should include("123")
    end
end
