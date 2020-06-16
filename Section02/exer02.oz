% 2. The context of the context
/* Without this step, the behavior of the procedure MulByN changes each time it is called. This step is necessary because execution depends only on its arguments.*/

% Example where N does not exist in the environment at the time of calling
declare A=10 B

local MulByn in
   local N in
      N=3
      proc {MulByn X ?Y}
	 Y=N*X
      end
   end
   {MulByn A B}
   {Browse B} % =>30
   % {Browse N} => 'variable N not introduced'
end

% Example where N exists in the environment at the time of calling, but is bound to a value other than 3
declare A=10 B
local MulByn in
   local N in
      N=3
      proc {MulByn X ?Y}
	 Y=N*X
      end
   end
   local N in
      N=10
      {MulByn A B}
      {Browse B} % =>30
    % {Browse N} => 10
   end
end
