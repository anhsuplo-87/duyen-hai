const
	fi = 'CARD.INP';
	fo = 'CARD.OUT';
	nm = 100;
	nnm = 100;
var
	a : array[1..nm] of integer;
	f : array[0..nnm,0..nnm] of int64;
	n : integer;
	nn : longint;

procedure mofile;
begin
	assign(input,fi);
	reset(input);
	assign(output,fo);
	rewrite(output);
end;

procedure nhap;
var
	i : integer;
begin
	readln(n);
	for i := 1 to n do
		read(a[i]);
end;

function min(a,b : int64):int64;
begin
	if a < b then exit(a)
	else
	exit(b);
end;

procedure xuly;
var
	x,y,k : longint;
	rut : int64;
begin
	for x := 1 to n do
	for y := 1 to n do
	f[x,y] := high(int64);

	for k := 1 to n-1 do
	f[k,k+1] := 0;
	
	for x := n downto 1 do
		for y := x+1 to n do
			for k := x+1 to y-1 do
			begin
				rut := f[x,k] + f[k,y] + a[x]*a[k]*a[y];

				f[x,y] := min(f[x,y],rut);
			end;
end;

procedure inkq;
begin
	writeln(f[1,n]);
end;

begin
	mofile;
	nhap;
	xuly;
	inkq;
end.
