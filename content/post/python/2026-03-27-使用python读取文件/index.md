---
title: 2026-03-27 浣跨敤python璇诲彇鏂囦欢
tags:
  - python
date: 2026-03-27 08:00:00
image: 54943053_p0-a fantastical journey.webp
---

>涓嶄細鐢╬ython鏉ヨ鍙栨枃浠剁殑璇?鎴戞兂鏄笉澶彲鑳戒細瀛︿細鐖櫕鐨?涓嶇劧浣犳€庝箞澶勭悊鑾峰彇鐨勬暟鎹?
鏈枃鎵€鐢ㄧ殑weekly_hiring_comments.json绀轰緥鐨勭粨鏋勫涓?
```json
[
  {
    "issue": 692,
    "author": "ruanyf",
    "created_at": "2019-07-18T07:00:46Z",
    "text": "### **楂樼骇 Web 鍓嶇宸ョ▼甯?*\r\n  \r\n[娣卞湷杩戒竴绉戞妧](https://zhuiyi.ai/)锛屼汉宸ユ櫤鑳藉垱涓氬叕鍙搞€傚伐浣滃湴鐐癸細娣卞湷甯傚崡灞卞尯銆俓r\n\r\n鍏徃涓绘墦 NLP 鏂瑰悜鐨?B 绔?AI 浜у搧钀藉湴锛岃瘹姹傝嫳鎵嶃€傝姹?骞翠互涓婂疄闄呭墠绔」鐩殑寮€鍙戠粡楠岋紝鐔熺粌鎺屾彙 Vue 鎴?React 鐢熸€侊紝鏌ョ湅[璇︾粏淇℃伅](https://www.zhipin.com/job_detail/79ca9be7fb736e4d03Nz3924FVA~.html)銆俓r\n\r\nEmail 鑱旂郴锛歔winchang@wezhuiyi.com](mailto:winchang@wezhuiyi.com)",
    "url": "https://github.com/ruanyf/weekly/issues/692#issuecomment-512691467"
  },
//   ...
]
```
## open鏂规硶
璇诲啓鏂囦欢涓€鑸兘閫氳繃open鏂规硶鏉ヨ繘琛屾搷浣?鍩烘湰鐢ㄦ硶鐪嬩笅闈㈢殑浠ｇ爜灏卞緢瀹规槗鐞嗚В浜?
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

with open("鏈鍙婁互涓?json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)
```
涓変釜鍙傛暟鍒嗗埆涓?
1. file(鏂囦欢璺緞)
2. mode(鎿嶄綔鏂瑰紡)
3. encoding(瑙ｇ爜鏂瑰紡)

mode 鐨勫€煎寘鎷互涓嬪嚑绉?
- 'r' 锛岃〃绀鸿鍙栨枃浠?- 'w' 琛ㄧず鍐欏叆鏂囦欢锛堢幇鏈夊悓鍚嶆枃浠朵細琚鐩栵級
- 'a' 琛ㄧず鎵撳紑鏂囦欢骞惰拷鍔犲唴瀹癸紝浠讳綍鍐欏叆鐨勬暟鎹細鑷姩娣诲姞鍒版枃浠舵湯灏?- 'r+' 琛ㄧず鎵撳紑鏂囦欢杩涜璇诲啓
- **mode 瀹炲弬鏄彲閫夌殑锛岀渷鐣ユ椂鐨勯粯璁ゅ€间负 'r'**


褰撶劧,濡傛灉鐪嬫簮鐮佺殑璇濊繕鑳界湅鍒颁竴鍫嗗弬鏁?浣嗘垜浠竴鑸彧鐢ㄥ緱鍒颁笂杩扮殑涓変釜鍙傛暟:
```py
def open(
    file: FileDescriptorOrPath,
    mode: OpenTextMode = "r",
    buffering: int = -1,
    encoding: str | None = None,
    errors: str | None = None,
    newline: str | None = None,
    closefd: bool = True,
    opener: _Opener | None = None,
) -> TextIOWrapper: ...
```

鐜板湪鐨勯棶棰樻槸杩欎釜璇诲啓鐨勬枃浠朵細鏈夊緢澶氱鏍煎紡(.pdf,.txt,.json,.html,.js, ...),鎴戜滑鏉ョ湅鐪媜pen鏄€庝箞澶勭悊鐨?
1. text mode - 榛樿鏍煎紡: 閫氬父鎯呭喌涓?鏂囦欢浠ヨ妯″紡鎵撳紑,涓€鑸娇鐢╱tf-8杩涜缂栫爜,璇ユā寮忎富瑕佺敤浜庡鐞嗘枃鏈枃浠?2. binary mode - 浠ヤ簩杩涘埗妯″紡璇诲彇鏂囦欢,闇€瑕佸湪mode璇嶅熬鍔犱笂涓€涓?b',濡俙wb`,`ab`绛?鍦ㄤ簩杩涘埗妯″紡涓嬫棤娉曟寚瀹歟ncoding(涔熸病鏈夊繀瑕佹寚瀹?,璇ユā寮忎富瑕佺敤浜庤鍙?png,.mp3,.pdf杩欐牱鐨勪簩杩涘埗鏂囦欢

鎹㈠彞璇濊,open鍑芥暟鏍规湰涓嶄細瀵规瘡绉嶆枃浠惰繘琛岀壒娈婂鐞?鍙槸鏈変袱绉嶈鍙栨柟寮忚€屽凡浜?瀵逛簬涓€浜涚壒娈婄殑鏂囦欢鏍煎紡,鎴戜滑閮介渶瑕侀澶栫敤鍏朵粬搴撳幓澶勭悊.

浣嗘槸瀵逛簬涓€鑸殑鏂囦欢鏍煎紡,open鍑芥暟璇诲彇鏂囦欢鍚嶅悗浼氳繑鍥炰竴涓猅extIOWrapper瀵硅薄,瀹冩湁涓ょ甯哥敤鐨勬柟娉?
1. .read()鏂规硶: 灏嗗叏鏂囪鍏ヤ竴涓瓧绗︿覆鍙橀噺
   1. 渚嬪瓙: `content = f.read()`
2. .write()鏂规硶: 鍐欏叆瀛楃涓?   1. 渚嬪瓙: `f.write(f"## 鎷涜仒 \n\n")`


### json绯荤粺搴?澶勭悊json鏂囦欢
鏃㈢劧鏄郴缁熷簱,閭ｈ嚜鐒惰鍏堝鍏ュ悗浣跨敤,浜嬪疄涓婂彧鏈変袱涓父鐢ㄥ嚱鏁? json.load()鍜宩son.dump().

**绀轰緥**
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

bachelor_posts = []

with open(out_dir / "鏈鍙婁互涓?json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)
```
鐪嬬湅婧愮爜鍜屽弬鏁?
```py
# load()
(function) def load(
    fp: SupportsRead[str | bytes],
    *,
    cls: type[JSONDecoder] | None = None,
    object_hook: ((dict[Any, Any]) -> Any) | None = None,
    parse_float: ((str) -> Any) | None = None,
    parse_int: ((str) -> Any) | None = None,
    parse_constant: ((str) -> Any) | None = None,
    object_pairs_hook: ((list[tuple[Any, Any]]) -> Any) | None = None,
    **kwds: Any
) -> Any

# dump()
(function) def dump(
    obj: Any,
    fp: SupportsWrite[str],
    *,
    skipkeys: bool = False,
    ensure_ascii: bool = True,
    check_circular: bool = True,
    allow_nan: bool = True,
    cls: type[JSONEncoder] | None = None,
    indent: int | str | None = None,
    separators: tuple[str, str] | None = None,
    default: ((Any) -> Any) | None = None,
    sort_keys: bool = False,
    **kwds: Any
) -> None
```
閫熻涓€涓嬪氨鐭ラ亾鐢ㄦ硶浜?璇籮son鏂囦欢鏃舵寚瀹氭枃浠跺悕,鍐檍son鏂囦欢鏃舵寚瀹氬啓鍏ュ唴瀹瑰拰鍐欏叆鏂囦欢鍚嶅氨鍙互浜?### 澶勭悊md鏂囦欢
md鏂囦欢娌℃湁涓撻棬鐨勫簱,鐩存帴璇诲啓灏卞彲浠ヤ簡
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

out = Path("weekly_hiring_comments.md")

with out.open("w", encoding="utf-8") as f:
    for i, p in enumerate(posts, 1):
        f.write(f"## 鎷涜仒 {i}\n\n")
        f.write(f"- Issue: #{p['issue']}\n")
        f.write(f"- 浣滆€? {p['author']}\n")
        f.write(f"- 鏃堕棿: {p['created_at']}\n")
        f.write(f"- 鏉ユ簮: {p['url']}\n\n")
        f.write(p["text"])
        f.write("\n\n---\n\n")
```

## pathlib搴?**璇ュ簱鍦ㄤ笉鍚屽钩鍙颁笅閮借兘杞绘澗璇诲彇鏂囦欢璺緞**,鑰屼笉闇€瑕佹搷蹇冪郴缁熼棶棰樻垨鑰呭瓧绗︿覆闂.

- [瀹樻柟鏂囨。](https://docs.python.org/zh-cn/3/library/pathlib.html)

>濡傛灉浠ュ墠浠庢湭鐢ㄨ繃姝ゆā鍧楋紝鎴栦笉纭畾鍝釜绫婚€傚悎瀹屾垚浠诲姟锛岄偅瑕佺敤鐨勫彲鑳藉氨鏄?Path銆傚畠鍦ㄨ繍琛屼唬鐮佺殑骞冲彴涓婂疄渚嬪寲涓哄叿浣撹矾寰?

鎺ヤ笅鏉ユ垜浠潵璇︾粏浠嬬粛杩欎釜Path瀵硅薄
### Path瀵硅薄鐨勫垱寤?```py
from pathlib import Path

# 鍩虹鐢ㄦ硶
out_file: Path = Path("a.md")

# 鎷兼帴璺緞鐨勪袱绉嶅啓娉?
# 绠€鍐?out_file: Path = Path("modules") / "a.py"

# 鍒嗗紑鍐?out_dir: Path = Path("modules")
out_file: Path = out_dir / "issues.md"

```
涓婅堪鐨勪唬鐮佺敱浜庢病鏈夋寚瀹氱粷瀵硅矾寰?鏁呴兘鏄浉瀵逛簬python杩愯鐩綍鐨勮矾寰?浣嗘垜浠篃鍙互鎸囧畾缁濆璺緞,濡備笅鏂囨墍绀?
```py
from pathlib import Path

# Windows 椋庢牸
abs_path_win = Path("C:/Users/Admin/Desktop/a.md")

# Linux/macOS 椋庢牸
abs_path_unix = Path("/home/user/project/a.md")
```
涔熷氨鏄,鎴戜滑涓嶉渶瑕佸啀鍘绘姌鑵句笉鍚屾搷浣滅郴缁熺殑璺緞闂浜?缁熶竴鐢╜/`灏卞彲浠ョ‘瀹氱浉瀵圭殑璺緞.
### 浣跨敤Path鏉ュ垱寤烘枃浠跺す
鍙渶瑕佽皟鐢╩kdir鏂规硶鍗冲彲:
```py
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)
```
- exist_ok鍙傛暟鐨勪綔鐢? 榛樿涓篎alse,璁剧疆涓篢rue鏃?鍗充究褰撳墠璺緞涓嬫湁杩欎釜鏂囦欢澶?涔熶笉浼氭姤閿?### Path瀵硅薄鐨刼pen鏂规硶
浜嬪疄涓?杩欎釜open鏂规硶涓巔ython鍐呯疆鐨刼pen鏂规硶鍩烘湰娌℃湁鍖哄埆,鍙槸鎶婃枃浠惰矾寰勬彁鍒板闈㈡潵浜嗚€屽凡:
```py
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)

for issue, items in by_issue.items():
    path = out_dir / f"issue_{issue}.md"
    with path.open("w", encoding="utf-8") as f:
        f.write(f"# Issue #{issue} 鎷涜仒姹囨€籠n\n")
```

### Path瀵硅薄鐨刧lob鏂规硶(寰呰ˉ鍏?

### 瀹炴垬
```py
import json
from pathlib import Path
from collections import defaultdict

with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)
# 璇诲彇json鍒楄〃
by_issue = defaultdict(list)
for p in posts:
    by_issue[p["issue"]].append(p)
# 澶勭悊涓轰竴涓湁搴忓瓧鍏?杩欏湪json鍒楄〃鏈韩鏄棤搴忕殑鏃跺€欐瘮杈冨ソ鐢?out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)

for issue, items in by_issue.items():
    path = out_dir / f"issue_{issue}.md"
    with path.open("w", encoding="utf-8") as f:
        f.write(f"# Issue #{issue} 鎷涜仒姹囨€籠n\n")

        for i, p in enumerate(items, 1):
            f.write(f"## 鎷涜仒 {i}\n\n")
            f.write(f"- 浣滆€? {p['author']}\n")
            f.write(f"- 鏃堕棿: {p['created_at']}\n")
            f.write(f"- 鏉ユ簮: {p['url']}\n\n")
            f.write(p["text"])
            f.write("\n\n---\n\n")
```

## re绯荤粺搴?- [瀹樻柟鏂囨。](https://docs.python.org/zh-tw/3.8/library/re.html)

璇ュ簱鏄姝ｅ垯琛ㄨ揪寮?regular expression)鐨勫皝瑁?鎵€浠ュ彨re.

### compile鏂规硶
compile鏄竴涓疄渚嬪寲pattern瀵硅薄鐨勬柟娉?pattern涓€璇嶅湪re涓寚鐨勬槸姝ｅ垯琛ㄨ揪寮忓瓧绗︿覆
```py
prog = re.compile(pattern)
result = prog.match(string)
# 涓婅堪浠ｇ爜绛変环浜庝笅闈㈢殑杩欎釜
result = re.match(pattern, string)
# 涓轰簡瑙勮寖鍖栧拰澶嶇敤,鎴戜滑杩樻槸澶氱敤compile鏂规硶鏉ユ寚鏄巔attern瀵硅薄
```

>浜嬪疄涓?re搴撲腑鐨勫ぇ澶氭暟甯哥敤鏂规硶閮芥湁涓ょ鍐欐硶,涓€绉嶆槸`妯″紡.鏂规硶(鍙傛暟)`,鍙︿竴绉嶆槸`鏂规硶.(妯″紡,鍙傛暟)`.涓轰簡瑙勮寖璧疯,鎴戜滑鍚庨潰閮介噰鐢╜妯″紡.鏂规硶(鍙傛暟)`鍐欐硶,灏变笉鍐嶆璇存槑浜?


### search鏂规硶涓巑atch鏂规硶
- [鑿滈笩鏁欑▼](https://www.runoob.com/python/python-reg-expressions.html)

>re.match鍙尮閰嶅瓧绗︿覆鐨勫紑濮嬶紝濡傛灉瀛楃涓插紑濮嬩笉绗﹀悎姝ｅ垯琛ㄨ揪寮忥紝鍒欏尮閰嶅け璐ワ紝鍑芥暟杩斿洖None锛涜€宺e.search鍖归厤鏁翠釜瀛楃涓诧紝鐩村埌鎵惧埌涓€涓尮閰嶃€?
```py
#!/usr/bin/python
import re
 
line = "Cats are smarter than dogs";
 
matchObj = re.match( r'dogs', line, re.M|re.I)
if matchObj:
   print "match --> matchObj.group() : ", matchObj.group()
else:
   print "No match!!"
 
matchObj = re.search( r'dogs', line, re.M|re.I)
if matchObj:
   print "search --> searchObj.group() : ", matchObj.group()
else:
   print "No match!!"
```
**杩愯缁撴灉**
```bash
No match!!
search --> searchObj.group() :  dogs
```

### 瀹炴垬
涓嬮潰鐨勬暣涓唬鐮佹祦绋嬩负:
1. 杞藉叆json鏂囦欢涓哄垪琛╬osts
2. 浣跨敤compile鏂规硶缁勭粐鍖归厤妯″紡
3. 灏唒osts閲屽搴斿鍘嗚姹傜殑甯栧瓙涓殑text瀛楁閲岀殑鍊兼彃鍏ュ垪琛ㄤ腑
4. 瀵煎嚭json鏂囦欢
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

bachelor_patterns = [
    r"鏈鍙婁互涓?,
    r"鏈浠ヤ笂",
]

master_patterns = [
    r"纭曞＋鍙婁互涓?,
    r"纭曞＋浠ヤ笂",
]
# 杩欓噷鐨剅鏄负浜嗙鐢╜\`杞箟绗?浣嗚繖閲岄兘鏄腑鏂?涓嶅啓涔熷彲浠?涓轰簡瑙勮寖鎵€浠ュ姞涓婁簡

bachelor_re = re.compile("|".join(bachelor_patterns))
master_re = re.compile("|".join(master_patterns))
# 鎷兼帴浜嗕袱涓尮閰嶅瓧绗︿覆

bachelor_posts = []
master_posts = []

for p in posts:
    # 杩欎釜p鏄垪琛ㄧ殑瀛愬厓绱?鍦ㄨ繖閲屼负瀛楀吀
    text = p.get("text", "")
    # get鏂规硶鐨勭涓€涓弬鏁版槸,鏌ユ壘璇ュ瓧鍏镐腑鐨勫搴斿瓧娈靛苟杩斿洖鍊?绗簩涓弬鏁版槸,鑻ユ煡鎵句笉鍒拌繑鍥炵殑榛樿鍊?    if master_re.search(text):
        master_posts.append(p)
    elif bachelor_re.search(text):
        bachelor_posts.append(p)

# === 杈撳嚭鐩綍 ===
out_dir = Path("degree_split")
out_dir.mkdir(exist_ok=True)

# === 鍐欐枃浠?===
with open(out_dir / "鏈鍙婁互涓?json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)

with open(out_dir / "纭曞＋鍙婁互涓?json", "w", encoding="utf-8") as f:
    json.dump(master_posts, f, ensure_ascii=False, indent=2)

```



## 璇诲彇.env鏂囦欢
瀵逛簬瀵嗙爜,API瀵嗛挜杩欎簺鏂囦欢,鐢╦son鏂囦欢瀛樺彇涓嶅鏂逛究涔熶笉澶熷畨鍏?鍥犳鎴戜滑鏈変簡.env鏂囦欢,鏍峰紡濡備笅:
```toml
# github token
token="ghp_xxxxxxxxxxxx"
```
褰撴垜浠兂瑕佽鍙栬繖涓?env鏂囦欢涓殑token瀛楁鏃?鎴戜滑鍙互瀵煎叆dotenv搴撳拰os搴撴潵杩涜绠€鍗曠殑璇诲彇:
```py
from dotenv import load_dotenv
import os

load_dotenv()
TOKEN = os.getenv("token")
```
`load_dotenv()`鍑芥暟浼氶€掑綊瀵绘壘.env鏂囦欢骞惰繑鍥炲唴瀹逛緵os搴撹鍙?浠庤€岄伩鍏嶄簡鍐欒矾寰勭殑楹荤儲.
