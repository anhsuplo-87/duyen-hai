const
	fi = 'SELECT.INP';
	fo = 'SELECT.OUT';
	nm = 10000;
	bitmask : array[1..8] of byte = (0,1,2,4,5,8,9,10);
var
	a : array[1..nm,1..4] of longint;
	f : array[0..nm,0..8] of int64;
	n : longint;
	res : int64;
procedure mofile;
begin
	assign(input,fi); reset(input);
	assign(output,fo); rewrite(output);
end;
procedure nhap;
var
	i,j : longint;
begin
	readln(n);
	for i := 1 to n do
	for j := 1 to 4 do
	read(a[i,j]);
end;
function bit (x, j : byte): byte;
begin
	exit((x shr j) and 1);
end;
function max(a,b : int64):int64;
begin
	if a > b then
		exit(a)
	else
		exit(b);
end;
procedure xuly;
var
	i,k : longint;
	j,p : byte;
	tg : longint;
begin
	fillchar(f,sizeof(f),0);
	for i := 1 to n do
		for j := 1 to 8 do
		begin
			tg := 0;
			for k := 1 to 4 do
				tg := tg + bit(bitmask[j], k-1)*a[i,k];
			for p := 1 to 8 do
				if ((bitmask[j] and bitmask[p]) = 0) and (f[i,j] < f[i-1,p] + tg) then
				f[i,j] := f[i-1,p] + tg;
		end;
	for i := 1 to 8 do
	res := max(res, f[n,i]);
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
