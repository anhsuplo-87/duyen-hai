const
	fi = 'HISTOGRAM.INP';
	fo = 'HISTOGRAM.OUT';
	nm = 15;
	nnm = 33000;
var
	a : array[1..nm] of integer;
	f,s : array[0..nnm, 1..nm] of longint;
	c : array[1..nm,1..nm] of longint;
	n,nn,res,ress : longint;

procedure mofile;
begin
	assign(input,fi);
	reset(input);
	assign(output,fo);
	rewrite(output);
end;

procedure nhap;
var
	i : longint;
begin
	readln(n);
	for i := 1 to n do
		read(a[i]);
  readln;
end;

procedure taomang;
var
	i,j : longint;
begin
	fillchar(c,sizeof(c),0);
	for i := 1 to n do
		for j := 1 to n do
			if a[i] < a[j] then
				inc(c[i,j], (2*abs(a[i]-a[j])));
end;

function bit(x : longint; j : byte):byte;
begin
	exit((x shr (j-1)) and 1);
end;

procedure xuly;
var
	x,y,i,j : longint;
begin
	taomang;
	fillchar(s,sizeof(s),0);
	fillchar(f,sizeof(f),0);
	for x := 1 to n do
	begin
		f[ (1 shl (x-1)), x] := 2*a[x] + 2;
		s[ (1 shl (x-1)), x] := 1;
	end;

	nn := (1 shl n) - 1;

	for x := 0 to nn do
		for i := 1 to n do
			if (bit(x,i) = 1) then
				for j := 1 to n do
					if (bit(x,j) = 0) then
						begin
							y := x + (1 shl (j-1));

							if f[y,j] <= f[x,i] + c[i,j] + 2 then
							begin
								if f[y,j] < f[x,i] + c[i,j] + 2 then
									s[y,j] := s[x,i]
								else
									s[y,j] := s[y,j] + s[x,i];

								f[y,j] := f[x,i]+c[i,j] + 2;
							end;
						end;

	res := -maxlongint;
	ress := 0;
	for i := 1 to n do
		if f[nn,i] > res then
			begin
				res := f[nn,i];
				ress := s[nn,i];
			end
		else
			if f[nn,i] = res then
			inc(ress, s[nn,i]);

	writeln(res,' ',ress);
end;

procedure process;
begin
	nhap;
	while n <> 0 do
	begin
		xuly;
		nhap;
	end;
end;

begin
	mofile;
	process;
end.
