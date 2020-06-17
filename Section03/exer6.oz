% 6. State unchanged expression


fun {Reverse Xs}
   fun {IterReverse Xs Ys}
      case Xs
      of nil then Ys
      [] X|Xr then {IterReverse Xr X|Ys}
      end
   end
in
   {IterReverse Xs nil}
end

% Intermediate state: (remaining list, already inverted list) = (Ys,Zs), so
% P((Ys,Zs)) ::= ( Xs = Append(Reverse(Zs),Ys) )

% Proof
% ■ First, prove P (initial state). This is from the initial state=(Xs,nil) to the right side=Append(nil,Xs), which is equal to Xs.
% ■ Suppose P(S_(i)) (not the final state) is true. At this time, Xs=Append(Reverse(Zs),Ys). If S|(i+1) is Z|Zr=Zs from the'case' statement, {Append Reverse(Zr) Z|Ys}={Append Reverse(Zs) Ys} is apparent in (Zr,Z|Ys). So, from the assumption, P(S_(i+1))=(Xs=Append(Reverse(Zr),Z|Ys)) is true. (Derivation of Reverse(Zr) from Reverse(Zs) is omitted.)
% *S_(final) (final state) = (nil,Zs), and from the'case' statement, this function returns Zs. Since Xs=Append(Reverse(Zs),nil), that is, Xs=Reverse(Zs), this result is correct. (From this point of view, Reverse(Xs)=Append(Zs,Reverse(Ys)) was a more appropriate statement.)
