module ApplicationHelper

    def render_if(condition, record)
        if condition 
          render record
        end
    end

    def format_price(amount)
       number_to_currency(amount, unit: '€', precision: 2, separator: ',', delimiter: '', format: "%n%u")
    end

end
