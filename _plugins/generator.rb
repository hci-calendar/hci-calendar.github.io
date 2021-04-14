
module Jekyll

  class Test < Liquid::Block
    include Convertible

    def initialize(tag_name, markup, parse_context)
      super

      @attributes = {}

      print(markup)

      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = value
        print(key + " = " + value + "\n")
      end
    end

    def latest_year_date_by_name_type(name, type)
      conf = @data['conference'][name]
      latest = conf['years'][0]
      date = nil

      if type == nil
        date = latest['date']
      else
        for item in latest['submissions']
          if item['type'] == type
            date = item['date']
          end
        end
      end
      {
        'name' => conf['abbr-name'],
        'year' => latest['year'],
        'date' => date
      }
    end

    def abbr_in_category(category)

    end

    def conferences_by_month(category, month, type)
      conferences = @data['category'][category]

      items = {}
      for key in conferences
        year_date = self.latest_year_date_by_name_type(key, type)
        items.store(key, year_date)
      end

      month_items = {}

      for i in (1..12)
        month = DateTime.parse("2020-" + i.to_s + "-01").strftime("%B")
        month_items.store(month, [])
      end

      items.each do |key, value|
        if value['date'] != nil
          month = DateTime.parse(value['date']).strftime("%B")
          month_items[month].push(value)
        end
      end

      month_items
    end

    def render(context)
      context.registers[:test] ||= Hash.new(0)
      @data = context.registers[:site].data

      result = []

      context.stack do
        if @attributes['func'] == ""
          category = @attributes['category']
          context['category'] = category
          # context['conferences'] = self.conferences_by_category(category)

        elsif @attributes['func'] == "month"
          category = @attributes['category']
          month = @attributes['month']
          # type = @attributes['type']
          type = context['type']
          # print('type = ' + context['type'] + "\n")
          context['month_items'] = self.conferences_by_month(category, month, type)
        end

        result << nodelist.map{|n|
          if n.respond_to? :render
            n.render(context)
          else
            n
          end
        }.join("")

      end
      result
    end

  end

end

Liquid::Template.register_tag('test', Jekyll::Test)
