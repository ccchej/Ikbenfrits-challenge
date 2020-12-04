class PastryService
    def self.combinationsUtil(arr, index, num, reducedNum)
    
      if reducedNum < 0
        return
      end
  
      if reducedNum == 0    
        i = 0
        new_str = ""
        
        while(i < index)
          new_str = [new_str, arr[i]].join(',')
          i+=1
        end
        @combinations << new_str
        return new_str
      end
      
      prev = index == 0 ? 1 : arr[index-1];

      k = prev
      while k<=num
        arr[index] = k
        combinationsUtil(arr, index + 1, num, reducedNum - k)
        k+=1
      end
  
    end 
      
    def self.findCombinations(n)
      arr = Array.new(n)
      combinationsUtil(arr, 0, n, n)
    end
    
    # ditribute the packs
    def self.distribute(packs, needed)
      # initialize the combinations
      @combinations = []
      
      # find combinations base on the needed
      findCombinations(needed.to_i)
      
      # get the qty denaminations
      denominations = packs.pluck('qty', 'id').to_h.keys
      
      # process the filtering of the combination
      filtered_combinations = []
      filtered_combinations = denominations.map { |deno| @combinations.select{|c| c.include?(deno.to_s)} }.try(:flatten).try(:uniq)
      
      # filter the filtered_combinations
      most_filtered = []
      filtered_combinations.map {|combination| most_filtered << combination if (combination.split(",").reject{|c| c == ""}.map(&:to_i) - denominations.map(&:to_i)).blank? }.flatten.compact
  
      # finalize the denominations
      finalized_denominations = []
      if most_filtered.blank?
        denos = []
        filtered_combinations.map {|combination| denominations.map{|deno| denos << deno if combination.include?(deno.to_s)}}
        if denos.present?
          smaller_or_equal_denos = denos.uniq.select{|c| c <= n }
          if smaller_or_equal_denos.present? 
            deno_hash = []
            smaller_or_equal_denos.each_with_index do |deno, index|
              total = 0
              inc = 2
              loop do 
                total = deno * inc
                break if total >= n 
                inc+=1
              end
              deno_hash << {"#{deno}" => "#{inc}"}
            end
            finalized_denominations << deno_hash 
          end
        end
      else
        most_filtered.each do |combination|
          refined_combination = combination.chars.reject!{|c| c == ","}
          @hsh_combination = {}
          refined_combination.uniq.each do |uniqee|
            @hsh_combination.merge!("#{uniqee}" => refined_combination.count(uniqee))
          end
          finalized_denominations << @hsh_combination
        end
      end
      finalized_denominations  
    end
  
    def self.denomination(denominations)
      denominations.select{|c| c.keys.include?(denominations.map(&:keys).flatten.max)}
    end
  
    def self.configure_order(code, needed)
      packs = Pack.where(code: code).all
      denomination_sets = distribute(packs, needed)
      denomination_sets = denomination_sets.count == 1 ? denomination_sets : denomination(denomination_sets)
      first_pack = packs.first
      order = {
        code: first_pack.code,
        name: first_pack.pastry.name,
        total: 0,
        packs: []
      }
      packs.each do |pack|
        denomination_sets.each do |denomination_set|
          keys = denomination_set.keys
          values = denomination_set.values
          
          if keys[0].to_i.equal?(pack.qty)
            qty = values[0]
            unit_price = (qty.to_f*pack.price.to_f).round(2)
            order[:packs].push({
              pcs: keys[0],
              qty: qty,
              price: pack.price,
              unit_price: unit_price
            })
            order[:total] += unit_price
          end
          
          if keys[1].to_i.equal?(pack.qty)
            qty = values[1]
            unit_price = (qty.to_f*pack.price.to_f).round(2)
            order[:packs].push({
              pcs: keys[1],
              qty: qty,
              price: pack.price,
              unit_price: unit_price
            })
            order[:total] += unit_price
          end
        end
      end
      order
    end
  end