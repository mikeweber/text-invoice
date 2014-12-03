module TextInvoice
  class Totals
    def process(invoice)
      # parse
      parsed = YAML.load(invoice)

      # total accumulator
      total = 0

      # process line items
      if not parsed["items"] == nil
        for item in parsed["items"]
          quantity         = item["quantity"]
          unit             = item["unit"]
          subtotal         = quantity * unit
          item["subtotal"] = as_dollar(subtotal)
          total           += subtotal
          item["unit"]     = as_dollar(unit)
        end
      end

      # update totals
      parsed["total"] = as_dollar(total)
      parsed["due"]   = as_dollar(total - parsed["paid"].to_f)
      parsed["paid"]  = as_dollar(parsed["paid"].to_f)

      parsed.to_yaml
    end

    def as_dollar(num)
      '$' + with_commas('% 9.2f' % num)
    end

    def with_commas(num)
      new_num = num.reverse.gsub(/(\d{3})(?=\d)/, '\\1,')
      new_num[0..-(new_num.scan(',').size + 1)].reverse
    end
  end
end
