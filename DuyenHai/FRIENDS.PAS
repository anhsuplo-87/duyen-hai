const
	fi = 'FRIENDS.INP';
	fo = 'FRIENDS.OUT';
	nm = 16;
	mm = 10000;
	nnm = 66000;
var
	f,r,n : byte;
	m,nxm,nn,res,dl : longint;
	tr1,tr2,ci,d1,d2 : array[1..nnm] of integer;
	c : array[1..nm,1..nm] of longint;
	xm : array[0..nnm] of longint;
	fx : array[0..nnm] of longint;

procedure mofile;
begin
	assign(input,fi);
		reset(input);
	assign(output,fo);
		rewrite(output);
end;

procedure nhap;
var
	i,u,v : longint;
begin
	read(f,r);
		readln;
	readln(n);
	readln(m);
	for i := 1 to m do
	begin
		read(u,v,ci[i]);
		inc(c[u,v],(r-f)*ci[i]);
		inc(c[v,u],(r-f)*ci[i]);
		readln;
	end;
end;

function bit(x : longint; j : byte):byte;
begin
	exit((x shr (j-1)) and 1);
end;

procedure taomang;
var
	i,j,dem : longint;
begin
	nn := (1 shl n) - 1;
	for i := 1 to nn do
	begin
		dem := 0;
		for j := 1 to n do
			if bit(i,j) = 1 then
				inc(dem);
		if dem mod 2 = 0 then
		begin
			inc(nxm);
			xm[nxm] := i;
		end;
	end;
end;

procedure xuly;
var
	i,x,u,v : longint;
begin
  fillchar(fx,sizeof(fx),0);

	for i := 0 to nxm do
		begin
			for u := 1 to n do
			if bit(xm[i],u) = 0 then
			break;
			for v := u+1 to n do
			if bit(xm[i],v) = 0 then
				begin
					x := xm[i] + (1 shl (u-1)) + (1 shl (v-1));
					if (fx[x] < fx[xm[i]] + c[u,v]) then
					begin
						fx[x] := fx[xm[i]] + c[u,v];
						tr1[x] := u;
						tr2[x] := v;
					end;
				end;
		end;

  res := nn;
  dl := 0;
  repeat
    inc(dl);
    d1[dl] := tr1[res];
    d2[dl] := tr2[res];
    dec(res, ((1 shl (d1[dl] - 1)) + (1 shl (d2[dl] - 1))) );
  until (res = 0);

  fx[nn]:=-fx[nn];
	for i := 1 to m do
	inc(fx[nn],ci[i]*r);
	writeln(fx[nn]);

	for i := dl downto 1 do
	writeln (d1[i],' ',d2[i]);
end;

begin
	mofile;
	nhap;
	taomang;
	xuly;
end.
