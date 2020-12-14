require "byebug"
class Array

    def my_each(&block)
        for i in 0...self.length()
            block.call(self[i])
        end
        return self
    end

    def my_select(&block)
        soln = []
        self.my_each do |ele|
            if block.call(ele) 
                soln << ele
            end
        end
        return soln
    end

    def my_reject(&block)
        return self - self.my_select {|ele| block.call(ele) == true}
    end

    def my_any?(&block)
        if self.my_select{|ele| block.call(ele)}.length >= 1
            return true
        else
            return false
        end
    end

    def my_all?(&block)
        if self.my_select{|ele| block.call(ele)}.length == self.length()
            return true
        else
            return false
        end
    end

    def my_flatten
        soln = []
        self.my_each do |ele|
            if ele.class == Array
                soln += ele.my_flatten
            else
                soln << ele
            end
        end
        return soln
    end

    def my_zip(*args)
        soln = []
    
        self.each.with_index do |ele, selfIdx|
            curr = []
            curr << ele
            args.each_with_index do |arg, argIdx|
                if arg[selfIdx] != nil 
                    curr << arg[selfIdx]
                else
                    curr << nil
                end
            end
            soln << curr
        end
        return soln
    end

    def my_rotate(num = 1)                             #rotates leftward
        soln = self.my_select{|ele| ele}
        self.each.with_index do |char, idx|
            newindex = (idx -= num) % self.length      #leftward rotation
            soln[newindex] = char
        end
        return soln
    end

    def my_join(*separator)
        sep = ""
        separator.my_each {|ele| sep += ele}
        soln = ""
        self.my_each do |char|
            if separator and self.index(char) < self.length() and self.index(char) != 0
                soln += sep + char
            else
                soln += char
            end
        end
        return soln
    end

    def my_reverse
        soln = []
        self.my_each do |ele|
            soln.unshift(ele)
        end
        return soln
    end

    def bubble_sort!(&prc)
        swapped = false
        while swapped == false
            swapped = true
            for i in 0...self.length()-1
                num1 = self[i]
                num2 = self[i+1]
                # if prc[num1, num2] == 1
                #     self[i], self[i+1] = self[i+1], self[i]
                #     swapped = false
                # end
                if num1 > num2
                    self[i], self[i+1] = self[i+1], self[i]
                    swapped = false
                end
            end
        end
        return self
    end

    def bubble_sort(&prc)
        newArr = self.dup
        return newArr.bubble_sort!
    end

end

def factors(num)
    soln = []
    for i in 1..num
        if num % i == 0
            soln << i
        end
    end
    soln
end

def substrings(string)
    soln = []
    string.each_char.with_index do |char1, idx1|
        soln << char1 if !soln.include? char1
        temp = char1
        string.each_char.with_index do |char2, idx2|
            if idx2 > idx1
                temp += char2
                soln << temp if !soln.include? temp
            end
        end            
    end
    return soln
end

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]


