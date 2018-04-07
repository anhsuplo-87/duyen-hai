const
	fi = 'ELECTION.INP';
	fo = 'ELECTION.OUT';
	nm = 1000;
	rm = 1000000;
type
	mang = array[1..nm] of longint;
var
	a,ai,resi : mang;
	avail : array[0..rm] of boolean;
	trace : array[0..rm] of longint;
	t,res,sum,nres : longint;
	n : integer;

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
		ai[i] := i;
		inc(sum,a[i]);
	end;
end;

function max(a,b : longint):longint;
begin
	if a > b then exit(a)
	else
	exit(b);
end;

procedure swap(var a,b : longint);
var
	tg : longint;
begin
	tg := a;
	a := b;
	b := tg;
end;

procedure quicksort (var a : mang);

procedure sort (l,r : longint);
var
	i,j,m : longint;
begin
	i := l; j := r;
	m := a[(l+r) div 2];
	repeat
		while (a[i] > m) do inc(i);
		while (a[j] < m) do dec(j);
		if (i <= j) then
		begin
			swap(a[i],a[j]);
			swap(ai[i],ai[j]);
			inc(i);
			dec(j);
		end;
	until (i > j);
	if l < j then sort(l,j);
	if i < r then sort(i,r);
end;

begin
	sort(1,n);
end;

procedure xuly;
var
	i : longint;
begin
	avail[0] := true;
	quicksort(a);
	for i := 1 to n do
		for t := sum div 2 downto 0 do
			if not  avail[t+a[i]] and avail[t] then
				begin
					avail[t+a[i]] := true;
					res := max(res, t+ a[i]);
					trace[t+a[i]] := i;
				end;
end;

procedure tracing;
var
	i: longint;
begin
	nres := 0;
	while res <> 0 do
	begin
		inc(nres);
		resi[nres] := ai[trace[res]];
		dec(res, a[trace[res]]);
	end;
end;

procedure inkq;
var
	i : longint;
begin
	writeln(nres);
	for i := 1 to nres do
	write(resi[i],' ');
end;

begin
	mofile;
	nhap;
	xuly;
	tracing;
	inkq;
end.
