const
	fi = 'GARLAN.INP';
	fo = 'GARLAN.OUT';
	mm = 15;
	nnm = 33000;
var
	a : array[1..mm] of ansistring;
	l : array[0..nnm, 1.. mm] of longint;
	f : array[0..nnm, 1..mm] of longint;
	c : array[0..mm, 0..mm] of longint;
	n,nn,m,res : longint;
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
	read(n,m);
	readln;
	for i := 1 to m do
		readln(a[i]);
end;
procedure khoitao;
var
	i,j,k : longint;
begin
	fillchar(c,sizeof(c),0);
	for i := 1 to m do
		for j := 1 to m do
			if i=j then
			begin
				for k := 1 to n do
				if a[i][k] = '1' then
				inc(c[0,j]);
			end
			else
			begin
				for k := 1 to n do
				if a[i][k] <> a[j][k] then
				inc(c[i,j]);
			end;
end;
function bit(x : longint; j : byte):byte;
begin
	exit((x shr (j-1)) and 1);
end;
procedure xuly;
var
	x,y,z,yn : longint;
begin
	for x := 1 to m do
		for y := 1 to n do
		if a[x][y] = '1' then
			inc(f[(1 shl (x-1)),x]);
	nn := (1 shl m) - 1;
	for x := 0 to nn do
		for y := 1 to m do
		if bit(x,y) = 1 then
			for z := 1 to m do
			if bit(x, z) = 0 then
			begin
				yn := x + (1 shl (z-1));

				if (f[yn,z] = 0) or (f[yn,z] > f[x,y] + c[y,z]) then
					f[yn,z] := f[x,y] + c[y,z];
			end;
	res := maxlongint;
	for x := 1 to m do
	if f[nn,x] < res then res := f[nn,x];
end;
procedure inkq;
begin
	writeln (res);
end;
begin
	mofile;
	nhap;
	khoitao;
	xuly;
	inkq;
end.
