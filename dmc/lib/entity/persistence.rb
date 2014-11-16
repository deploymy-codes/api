module Persistence

   def included(base)
     base.class_eval do
       attribute :id, Integer
     end
   end

end
