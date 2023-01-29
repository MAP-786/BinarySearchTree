require_relative 'Node.rb'
class Tree 
    attr_accessor:root 

    def initialize(array)
        @array = array 
    end 

    def build_tree()
        @root = Node.new(@array[0], nil, nil)
        for i in 1..@array.length-1 do
            @temp = @root 
            added = false 
            @NN = Node.new(nil, nil, nil) 
            while added == false 
                if @array[i].to_i == @temp.value.to_i
                    added = true
                else 
                    if @array[i].to_i <	@temp.value.to_i
                        if @temp.left == nil 
                            @NN.value = @array[i]
                            @temp.left = @NN
                            added = true 
                        else
                            @temp = @temp.left 
                        end
                    end 
                    if @array[i].to_i > @temp.value.to_i
                        if @temp.right == nil 
                            @NN.value = @array[i]
                            @temp.right = @NN
                            added = true 
                        else
                            @temp = @temp.right 
                        end
                    end
                end 
            end 
        end     
    end 
    
    
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end


    def insert(value)
        @temp = @root
        added = false 
        @NN = Node.new(value, nil, nil) 
        while added == false 
            if @NN.value.to_i == @temp.value.to_i
                puts "repeated value"
                added = true
            else 
                if @NN.value.to_i <	@temp.value.to_i
                    if @temp.left == nil 
                        @temp.left = @NN
                        added = true 
                    else
                        @temp = @temp.left  
                    end
                end 
                if @NN.value.to_i > @temp.value.to_i
                    if @temp.right == nil 
                        @temp.right = @NN
                        added = true 
                    else
                        @temp = @temp.right 
                    end
                end
            end 
        end   
    end 


    def delete(value)
        @temp = @root
        @pretemp = @root 
        while value.to_i != @temp.value.to_i
            #puts @temp.value
            if value  <	 @temp.value.to_i 
                @pretemp = @temp 
                @temp = @temp.left 
            else
                @pretemp = @temp 
                @temp = @temp.right 
            end 
        end 
        
        #no child 
        if @temp.left == nil && @temp.right == nil
            if value == @pretemp.left.value 
                @pretemp.left = nil 
            
            else  
                @pretemp.right = nil
            end 
        end 
        #one child 
        if @temp.left != nil && @temp.right == nil
            if value == @pretemp.left.value 
                @pretemp.left = @temp.left
            else
                @pretemp.right = @temp.left
            end 
        end 
        if @temp.left == nil && @temp.right != nil
            if value == @pretemp.right.value 
                @pretemp.right = @temp.right
            else
                @pretemp.left = @temp.right
            end 
        end
   

        @nodetodelete = @temp
        @prelargestval = @temp
        if @temp.right != nil && @temp.left != nil 
            @temp = @temp.right 
            while @temp.left != nil
                @prelargestval = @temp
                @temp = @temp.left
            end 
        
            #puts @temp.value.to_i
            
            if @temp.value != @nodetodelete.right.value
                @temp.right = @nodetodelete.right
            end 
            @temp.left = @nodetodelete.left
            @prelargestval.left = nil 
            if @pretemp.right != nil 
                if value == @pretemp.right.value
                    @pretemp.right = @temp
                else
                    @pretemp.left = @temp
                end
            end 
            if @pretemp.left != nil 
                if value == @pretemp.left.value
                    @pretemp.left = @temp
                else
                    @pretemp.right = @temp
                end
            end 
        end 
    end 

    def find(node, value)
        return node if node.value == value
    
        if value < node.value && node.left
          find(node.left, value)
        elsif value > node.value && node.right
          find(node.right, value)
        end
    end 
        
    def level_order()
        
    end 

    def inorder(node, array = [])
        return if node.nil?
    
        inorder(node.left, array)
        array << node.value
        inorder(node.right, array)
        array
    end
    
    def preorder(node, array = [])
        return if node.nil?
    
        array << node.value
        preorder(node.left, array)
        preorder(node.right, array)
        array
    end

    def postorder(node, array = [])
        return if node.nil?
    
        postorder(node.left, array)
        postorder(node.right, array)
        array << node.value
        array
    end

    def find_height(node)
        return -1 if node.nil?
    
        left_height = find_height(node.left)
        right_height = find_height(node.right)
        left_height + 1 > right_height + 1 ? left_height + 1 : right_height + 1
      end
    
    def height(node, value)
        target = find(node, value)
        find_height(target)
    end
    
    def depth(node, value, count = 0)
        count += 1
        return count - 1 if node.value == value

        if value < node.value && node.left
            depth(node.left, value, count)
        elsif value > node.value && node.right
            depth(node.right, value, count)
        end
        
    end 

    def balanced?(node)
        left_side = height(node.left, node.left.value)
        right_side = height(node.right, node.right.value)
        (left_side - right_side).abs > 1 ? false : true
    end

    def rebalance(node)
        @array = inorder(node)
        T.build_tree
        T.pretty_print()
    end

end




T = Tree.new([20, 18, 7, 4, 2, 16,17,18,19,23, 4, 6, 10, 9, 3, 5, 9, 1, 12, 15, 8, 11])
T.build_tree()
T.insert(25)
T.pretty_print()

T.delete(16)
#T.delete(7)
T.pretty_print()
#puts (T.find(12))
#T.printnodes()
T.inorder(@root)

print T.inorder(T.root)
puts " "

print T.preorder(T.root)
puts " "

print T.postorder(T.root)
puts " "

puts T.height(T.root,18)

puts T.depth(T.root, 2, 0)

puts T.balanced?(T.root)

puts T.rebalance(T.root)