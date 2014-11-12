module Persistence

   def included(base)
     base.class_eval do
       attr_accessor :id
     end
   end

end
