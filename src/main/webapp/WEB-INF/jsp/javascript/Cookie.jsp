<div id="last-modified">Last Modified : 2013.11.19</div>

<h1>자바스크립트로 쿠키 다루기</h1>

쿠키란 키-값 쌍의 작은 데이터인데, 파기 날짜, 도메인, 경로, 보안 정보를 추가적으로 가진다.<br />
서버 자원에서 쿠키 객체를 생성하면 쿠키 정보가 문자열로 응답의 헤더에 추가되어 웹 브라우저에 전달된다.<br /> 
웹 브라우저는 다음 요청부터 이 쿠키 정보를 요청 헤더에 담아 요청과 함께 보내게 된다.<br />
웹 브라우저에서 작동하는 자바스크립트에서도 쿠키를 다룰 수 있는데 이유는 
자바스크립트가 웹 브라우저에 전달된 응답 메시지의 쿠키 정보에 접근할 수 있기 때문이다.<br />
서버에서 전달되온 응답 헤더에 쿠키와 관련된 문자열이 없다 하더라도 자바스크립트가 응답 헤더를 
조작할 수 있으니 서버에서 전달된 것과 같은 효과를 낼 수 있는 것이다.<br />
결론적으로 서버 자원의 스크립트와 웹 브라우저에서의 자바스크립트 모두 쿠키를 생성, 설정, 제거할 수 있다.<br />
이 문서에서는 자바스크립트에서 쿠키를 다루는 방법을 설명한다.<br />

<h3>쿠키 생성</h3>
쿠키를 생성하려면 <br />
쿠키 이름=쿠키 값; 파기 날짜; 경로 <br />
이런 형태의 문자열을 만들어야 한다.<br />
다음 예제는 게시판 목록에서 페이지당 보일 레코드 수를 담을 쿠키를 생성하는 예제다.<br />
예제에서 setCookie() 함수는 쿠키 이름=쿠키 값; 파기 날짜 정보로 구성되는 쿠키를 만들 수 있다.<br />
설정하지 않은 도메인, 경로, 보안은 디폴트 값이 적용된다.<br />

<pre class="prettyprint">
function createCookie(name, value, days) {
	var cookieStr = name + "=" + escape(value);
	
	if (days) {
		var expires = new Date();
		expires.setDate(expires.getDate() + days);
		cookieStr += "; expires=" + expires.toGMTString();
	}
	
	document.cookie = cookieStr;
}

function readCookie(name) {
	var cookie = document.cookie;
	var beginIndex = cookie.indexOf(" " + name + "=");
	if (beginIndex == -1) {
		beginIndex = cookie.indexOf(name+"=");
	}
	if (beginIndex == -1) {
		return null;
	} else {
		beginIndex = cookie.indexOf("=", beginIndex) + 1;
		var endIndex = cookie.indexOf(";", beginIndex);
		if (endIndex == -1) {
			endIndex = cookie.length;
		}
		return unescape(cookie.substring(beginIndex, endIndex));
	}
	
}

function deleteCookie(name) {
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function setNumPerPage() {
	var selectElement = document.getElementById("numPerPage");
	var numPerPage = selectElement.value;
	createCookie('numPerPage',numPerPage,'100');
}
</pre>

위에서 setNumPerPage() 함수를 호출된다면<br /> 
100일 유효기간을 가진 numPerPage라는 쿠키가 만들어진다.<br />
이제 사용자가 웹브라우저로 게시판의 목록에 해당하는 list.jsp를 요청했다면 numPerPage라는 
쿠키도 함께 list.jsp로 전송된다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
&lt;%
int numPerPage = 10;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (int i = 0; i &lt; cookies.length; i++) {
	String name = cookies[i].getName();
	if (name.equals("numPerPage")) {
		numPerPage = Integer.parseInt(cookies[i].getValue());
	}
}

//..중간 생략..
%&gt;
</pre>

<em class="filename">list.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 쿠키 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
window.onload = initPage;

function initPage() {
	var select = document.getElementById("numPerPage");
	select.onchange = setNumPerPage;
	var showNPPBtn = document.getElementById("show-npp-btn");
	showNPPBtn.onclick = showCookie;
	var deleteNPPBtn = document.getElementById("delete-npp-btn");
	deleteNPPBtn.onclick = removeCookie;
}

function createCookie(name, value, days) {
	var cookieStr = name + "=" + escape(value);
	
	if (days) {
		var expires = new Date();
		expires.setDate(expires.getDate() + days);
		cookieStr += "; expires=" + expires.toGMTString();
	}
	
	document.cookie = cookieStr;
}

function readCookie(name) {
	var cookie = document.cookie;
	var beginIndex = cookie.indexOf(" " + name + "=");
	if (beginIndex == -1) {
		beginIndex = cookie.indexOf(name+"=");
	}
	if (beginIndex == -1) {
		return null;
	} else {
		beginIndex = cookie.indexOf("=", beginIndex) + 1;
		var endIndex = cookie.indexOf(";", beginIndex);
		if (endIndex == -1) {
			endIndex = cookie.length;
		}
		return unescape(cookie.substring(beginIndex, endIndex));
	}
}

function deleteCookie(name) {
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function setNumPerPage() {
	var selectElement = document.getElementById("numPerPage");
	var numPerPage = selectElement.value;
	createCookie('numPerPage',numPerPage,'100');
}

function showCookie() {
	var ret = readCookie("numPerPage");
	var cookiePrintDiv = document.getElementById("cookie-print");
	cookiePrintDiv.innerHTML = ret;
}

function removeCookie() {
	deleteCookie("numPerPage");	
}
//]]&gt;
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;select id="numPerPage"&gt;
	&lt;option value="10"&gt;10&lt;/option&gt;
	&lt;option value="25"&gt;25&lt;/option&gt;
	&lt;option value="50"&gt;50&lt;/option&gt;
	&lt;option value="100"&gt;100&lt;/option&gt;
&lt;/select&gt;
&lt;input type="button" id="show-npp-btn" value="쿠키값 확인" /&gt;
&lt;input type="button" id="delete-npp-btn" value="쿠키 삭제" /&gt;
&lt;div id="cookie-print"&gt;
&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/list.html">예제 실행</a><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://en.wikipedia.org/wiki/HTTP_cookie">http://en.wikipedia.org/wiki/HTTP_cookie</a></li>
	<li><a href="http://ezbuilder.tistory.com/34">http://ezbuilder.tistory.com/34</a></li>
	<li><a href="http://stackoverflow.com/questions/2144386/javascript-delete-cookie">http://stackoverflow.com/questions/2144386/javascript-delete-cookie</a></li>
</ul>