class QuickSort
 
  def self.sort!(keys, comparator)
    quick(keys,0,keys.size-1, comparator)
  end
 
  private
 
  def self.quick(keys, left, right, comparator)
    if left < right
      pivot = partition(keys, left, right, comparator)
      quick(keys, left, pivot-1, comparator)
      quick(keys, pivot+1, right, comparator)
    end
    keys
  end
 
  def self.partition(keys, left, right, comparator)
    x = keys[right]
    i = left-1
    for j in left..right-1
      if [-1,0].include? comparator.call(keys[j],x) 
        i += 1
        keys[i], keys[j] = keys[j], keys[i]
      end
    end
    keys[i+1], keys[right] = keys[right], keys[i+1]
    i+1
  end
 
end