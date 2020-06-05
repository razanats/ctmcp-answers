
% 7. Explicit state

local X in
   X=23
   local X in
      X=44
   end
   {Browse X}
end

local X in
   X={NewCell 23}
   X:=44
   {Browse @X}
end

% 23 is displayed for variables/44 is displayed for memory cells
% Regarding the variables: X of 23 and X of 44 are stored separately (storage variable). The last declared one works as an identifier.
