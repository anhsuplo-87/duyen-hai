const
	fi = 'GENETIC.INP';
	fo = 'GENETIC.OUT';
	nm = 20;
	cm = 1000;
	nnm = 1100000;
var
	a,b : array[1..nm] of integer;
	c : array[1..nm, 1..nm] of integer;
	f : array[0..nnm] of int64;
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
	i, ci : integer;
begin
	readln(n);
	for i := 1 to n do
	begin
		read(ci);
		a[ci] := i;
	end;
	for i := 1 to n do
	begin
		read(ci);
		b[ci] := i;
	end;
end;

procedure taomang;
var
	i,j : longint;
begin
	for i := 1 to n do
		for j := 1 to n do
			if (a[i] < a[j]) and (b[i] < b[j]) then
				c[i,j] := 1;
end;

function bit (x : longint; j : byte): byte;
begin
	exit(((x shr (j-1)) and 1));
end;

function check(x : longint; j : byte):boolean;
var
	k : longint;
begin
	for k := 1 to n do
	if (bit(x,k) = 0) and (c[k,j]=1) then
	exit(false);
	exit(true);
end;

procedure xuly;
var
	x,i,y : longint;
begin
	f[0] := 1;

	nn := (1 shl n) - 1;

	for x := 0 to nn do
		for i := 1 to n do
			if bit(x,i) = 0 then
				if check(x,i) then
					begin
						y := x + (1 shl (i-1));
						inc(f[y], f[x]);
					end;
end;

procedure inkq;
begin
	writeln(f[nn]);
end;

begin
	mofile;
	nhap;
  taomang;
	xuly;
	inkq;
end.
