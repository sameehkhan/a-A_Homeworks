class Stack
  def initialize
    @stack = []# create ivar to store stack here!
  end

  def push(el)
    stack.push(el)
  end

  def pop
    stack.pop
  end

  def peek
    stack[-1]# returns, but doesn't remove, the top element in the stack
  end
  
end
