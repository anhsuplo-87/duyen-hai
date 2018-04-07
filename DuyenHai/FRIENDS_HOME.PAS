const
	fi = 'FRIENDS.INP';
	fo = 'FRIENDS.OUT';
	nm = 16;
	mm = 10000;
	nnm = 66000;
var
	f,r,n : byte;
	m,nxm,nn,res,dl : longint;
	u,v,c,l1,l2 : array[1..mm] of integer;
	tf,tr : array[1..nm,1..nm] of longint;
	xm : array[0..nnm] of longint;
	fx : array[0..nnm] of array [1..nm,1..nm] of longint;

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
	read(f,r);
		readln;
	readln(n);
	readln(m);
	for i := 1 to m do
	begin
		read(u[i],v[i],c[i]);
		readln;
	end;
end;

procedure khoitao;
var
	i,j,k : longint;
begin
	for i := 1 to n-1 do
		for j := i+1 to n do
			for k := 1 to m do
				if ((i=u[k]) and (j = v[k])) or ((i=v[k]) and (j = u[k])) then
                                        inc(tf[i,j],c[k]*f)
                                else
                                if (i=u[k]) or (j = v[k]) or (i=v[k]) or (j = u[k]) then
                                        inc(tr[i,j],c[k]*r);
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
	i,x,y1,y2,z1,z2,lx,ly : longint;
begin
	for y1 := 1 to n-1 do
		for y2 := y1+1 to n do
			inc(fx[((1 shl (y1-1))+(1 shl (y2-1)))][y1,y2],tf[y1,y2]+tr[y1,y2]);
	for i := 0 to nxm do
		for y1 := 1 to n-1 do
			for y2 := y1+1 to n do
				if (bit (xm[i], y1) = 1) and (bit (xm[i], y2) = 1) then
					for z1 := 1 to n-1 do
						for z2 := z1+1 to n do
							if (bit (xm[i], z1) = 0) and (bit (xm[i], z2) = 0) then
								begin
									x := xm[i] + (1 shl (z1 - 1)) + (1 shl (z2 - 1));
									if (fx[x][z1,z2] = 0) or (fx[x][z1,z2] > fx[xm[i]][y1,y2]+tf[z1,z2]+tr[z1,z2]) then
									fx[x][z1,z2] := fx[xm[i]][y1,y2]+tf[z1,z2]+tr[z1,z2];
								end;
	res := maxlongint;
	for y1 := 1 to n-1 do
		for y2 := y1+1 to n do
                begin
			if (fx[nn][y1, y2] < res) and (fx[nn][y1,y2] <> 0) then
                        begin
		                res := fx[nn][y1, y2];
                                lx := y1;
                                ly := y2;
                        end;
                end;

	x := nn;
	repeat
                inc(dl);
                l1[dl] := lx;
                l2[dl] := ly;
		dec(x, ((1 shl (lx-1)) + (1 shl (ly-1))));
		dec(res, (tf[lx,ly]+tr[lx,ly]));
                if res = 0 then break;
		for y1 := 1 to n-1 do
			for y2 := y1+1 to n do
				if fx[x][y1,y2] = res then
					begin
						lx := y1;
						ly := y2;
					end;
	until res = 0;

        res := 0;
        for i := 1 to m do
        inc(res,c[i]*r);
        for i := 1 to dl do
        dec(res,(tf[l1[i],l2[i]] div f)*(r-f));
end;

procedure inkq;
var
        i : longint;
begin
        writeln(res);
        for i := 1 to dl do
        writeln (l1[i],' ',l2[i]);
end;

begin
	mofile;
	nhap;
	khoitao;
	taomang;
	xuly;
        inkq;
end.
