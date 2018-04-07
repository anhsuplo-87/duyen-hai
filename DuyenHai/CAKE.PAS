const
	fi = 'CAKE.INP';
	fo = 'CAKE.OUT';
	nm = 32;
	mm = 660;
var
	a : array[1..nm] of integer;
	f : array[0..mm,0..mm] of boolean;
	n : integer;
	sum, res : longint;
	
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
	sum := 0;
	for i := 1 to n do
	begin
		read(a[i]);
		inc(sum,a[i]);
	end;
end;

function maxmin(a,b : longint; k : shortint):longint;
begin
	if a*k > b*k then exit(a)
	else exit(b);
end;

procedure check(x,y : longint);
var
	z,k : longint;
begin
	f[x,y] := true;
	z := sum - x - y;
	k := maxmin(maxmin(x,y,1),z,1) - maxmin(maxmin(x,y,-1),z,-1);
	res := maxmin(res,k,-1);
end;

procedure xuly;
var	
	x,y,i : longint;
begin
	f[0,0] := true;
	res := maxlongint;
	for i := 1 to n do
		for x := sum div 3 downto 0 do
			for y := sum div 3 downto 0 do
				if (f[x,y]) then
				begin
					check(x+a[i],y);
					check(x,y+a[i]);
				end;
end;

procedure inkq;
begin
	writeln(res);
end;

begin
	mofile;
	nhap;
	xuly;
	inkq;
end.
