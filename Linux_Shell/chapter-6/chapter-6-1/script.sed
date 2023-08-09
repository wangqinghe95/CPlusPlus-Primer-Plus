1c hello world  # 匹配第一行数据并将该行数据替换成 hello world
2{              # 匹配第二行数据，先打印该行数据，并且将该行数据中第一个 g 修改为 g
    p 
    s/g/G/
}
/[0-9]/d        # 正则匹配有数字的行，删除
/beijing/{      # 正则匹配包含 beijing 的行，将该行的第一个 h 修改为 H，并且将该行的第一个 beijing 字符串修改为 china
    s/h/H/
    s/beijing/china/
}