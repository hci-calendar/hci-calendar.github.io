module Jekyll

  class Test < Liquid::Block
    include Convertible

    def initialize(tag_name, markup, parse_context)
      super

      @attributes = {}

      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = value
      end
    end

    def latest_year_date_by_name_type(name, type)
      conf = @data['conference'][name]
      latest = conf['years'][0]
      dates = []

      if type == nil
        dates.push(latest['date'])
      else
        for item in latest['submissions']
          if item['type'].include? type
            dates.push(item['date'])
          end
        end
      end

      date_list = []
      for date in dates
        date_list.push({
          'key' => name,
          'name' => conf['abbr-name'],
          'year' => latest['year'],
          'date' => date
        })
      end
      date_list
    end

    def conferences_by_month(category, type)
      conferences = @data['category'][category]

      items = []
      for key in conferences
        year_date = self.latest_year_date_by_name_type(key, type)
        items.push(*year_date)
      end

      month_items = {}

      for i in (1..12)
        month = DateTime.parse("2020-" + i.to_s + "-01").strftime("%B")
        month_items.store(month, [])
      end

      for item in items
        if item['date'] != nil
          begin
            month = DateTime.parse(item['date']).strftime("%B")
            month_items[month].push(item)
          rescue ArgumentError => e
            print(e.message + ": " + item['date'] + "\n")
          end
        end
      end

      month_items
    end

    def render(context)
      context.registers[:calendar] ||= Hash.new(0)
      @data = context.registers[:site].data

      result = []

      context.stack do
        if @attributes['func'] == ""


        elsif @attributes['func'] == "month"

          # get variables from context, not arguments
          category = context['category']
          type = context['type']

          # write result in context
          context['month_items'] = self.conferences_by_month(category, type)

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

  module CalendarFilter
    def push_conf(input, date)
      newlist = input.dup
      newlist.push({'type'=> 'Conference', 'date' => date})

      begin
        date = Date.parse(date)
      rescue ArgumentError => e
        print(e.message + ": " + value['date'] + "\n")
        date = nil
      end

      one_year_before = Date.new(date.year - 1, date.month, date.day)

      for item in newlist
        ratio = 100

        begin
          idate = Date.parse(item['date'])
          span = idate - one_year_before
          ratio = (100 * (span / 365)).to_i
        rescue ArgumentError => e
        end

        item['ratio'] = ratio

      end

      newlist
    end
  end
end

Liquid::Template.register_tag('calendar', Jekyll::Test)
Liquid::Template.register_filter(Jekyll::CalendarFilter)
