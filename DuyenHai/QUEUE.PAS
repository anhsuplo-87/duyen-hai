const
	fi = 'QUEUE.INP';
	fo = 'QUEUE.OUT';
	nm = 20;
var
	a : array[1..nm,1..nm] of longint;
	fx : array[0..1100000] of int64;
	n : byte;
	nn,max,y : longint;
procedure mofile;
begin
	assign(input,fi);
	reset(input);
	assign(output,fo);
	rewrite(output);
end;
procedure nhap;
var
	i,j : byte;
begin
	readln(n);
  fillchar(a,sizeof(a),0);
	for i := 1 to n do
		for j := 1 to n do
			read(a[i,j]);
end;
function popcount(n : longint): byte;
var
	dem : byte;
begin
	dem := 0;
	while n <> 0 do
	begin
		if n mod 2 = 1 then
		inc(dem);
    n := n div 2;
	end;
	exit(dem);
end;
function mu2 (n : byte):longint;
var
	i : byte;
begin
	mu2 := 1;
	for i := 1 to n do
	mu2 := mu2 * 2;
end;
function bit(x : longint; j : byte): byte;
begin
	exit((x shr (j-1)) and 1);
end;
procedure xuly;
var
	x,j,t : longint;
begin
  nn := mu2(n)-1;
  y := 0;
  fillchar(fx,sizeof(fx),0);

	for x := 0 to nn do
	begin
		t := popcount(x);
		for j := 1 to n do
		if bit(x,j) = 0 then
		begin
			y := x + mu2(j-1);

			if fx[y] < fx[x]+a[j,t+1] then
			fx[y] := fx[x]+a[j,t+1];
		end;
	end;
end;
procedure inkq;
begin
	writeln(fx[nn]);
end;
begin
	mofile;
	nhap;
	xuly;
	inkq;
end.
