% Implement ports

declare
proc {NewWrapper Wrap Unwrap}
   Key={NewName} in
   fun {Wrap X}
      {Chunk.new w(Key:X)}
   end
   fun {Unwrap W}
      try W.Key catch _ then raise error(unwrap(W)) end end
   end
end
   

declare NewPort Send
local Wrap Unwrap in
   {NewWrapper Wrap Unwrap}
   proc {NewPort Stream Port} S in 
      Port={Wrap {NewCell S}}
      Stream=!!S
   end
   proc {Send Port X} P in
      try 
	 P = {Unwrap Port}
      catch _ then
	 {Browse typerror}
      end
      local Si|Sr=@P in
	 Si = X
	 P := Sr
      end
   end
end

% The port is stored as a pair of a unique constant and the end of the stream in the abstract, but actually NewCell used when creating the port generates a unique identifier, so it should be pointed to the end...
