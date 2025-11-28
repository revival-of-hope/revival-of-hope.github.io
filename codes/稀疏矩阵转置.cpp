//先转90度再对称,顺时针转90度时col变row,row变n-row+1,对称时col变成n-row+1,即y2=n+1-y1,x2=n+1-x1;
那么要打印对应的转置元素a[i][j],就是打印a[n+1-i][n+1-j],遍历一次就行了
for(int i=1;i<=n;i++){
    for(int j=1;j<=n;j++){
        cout<<a[n+1-i][n+1-j]<<" ";
    }
}