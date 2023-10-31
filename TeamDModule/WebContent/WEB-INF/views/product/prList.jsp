<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl 추가 -->
<%@include file="../temp/header.jsp"%>
<c:set var="rPath" value="${pageContext.request.contextPath}/resources" />
<article>
	<header style="color: white">Fileupload Demo</header>
	<ul class="list-unstyled">
		<li class="border-top my-3">FileList</li>
	</ul>
	<div class="container">
		<table class="table table-bordered" id="upboardTable">

			<thead>
				<tr>
					<th colspan="6"><select id="sv" name="sv">
							<option value="0">Search</option>
							<option value="1">hit</option>
							<option value="2">bdate</option>
					</select></th>
				</tr>
				<tr>
					<th>번호</th>
					<th>이미지</th>
					<th>상품이름</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
				<%-- for start 
            ${vo.속성 } , ${map.key }
            List<BoardVO> list => BoardVO => e
            --%>
				<c:forEach var="e" items="${list}">
					<tr>
						<!-- <th>번호</th> -->
						<th scope="row">${e.pnum}</th>

						<td>${e.pname}</td>
						<td><fmt:formatNumber type="number" value="${e.price}" pattern="###,###" /></td>
					</tr>
				</c:forEach>
				<%-- for end --%>
			</tbody>
			<tfoot>
				<%-- page영역 --%>
				<%@include file="../temp/pageProcess.jsp"%>
				<%-- 검색영역 --%>
				<tr>
					<th colspan="6">
						<%-- 기존의 리스트 모델로 요청을 보낸다. --%>
						<form class="d-flex" method="post" action="uplist">
							<select class="form-control btn-mini" name="searchType" id="searchType" style="margin-left: 120px;">
								<option value="">검색</option>
								<option value="1">상품명</option>
								<option value="2">카테고리</option>
							</select> <input class="form-control me-2" type="text" placeholder="Search.." name="searchValue" id="searchValue" style="width: 300px">
							<button class="btn btn-outline-secondary" type="submit">Search</button>
						</form>
					</th>
				</tr>
				<tr>
					<td colspan="6" style="text-align: right;">
						<button type="button" class="btn btn-outline-secondary" onclick="location='upform'">글작성</button>
					</td>
				</tr>
			</tfoot>
		</table>



		<div class="searchArea">
			<input type="hidden" name="command" value="stList"> <select class="select-mode round-orange-hover" id="mode" name="mode">
				<option value="all" selected="selected">선택해 주세요
				<option value="stname">가게명
				<option value="category">카테고리
			</select> <select class="select-cate round-orange-hover" id="categoryList" name="categoryList">
				<option value="all" selected="selected">카테고리 리스트
				<option value="양식">양식
				<option value="중식">중식
				<option value="일식">일식
				<option value="한식">한식
				<option value="패스트푸드">패스트푸드
				<option value="치킨">치킨
				<option value="피자">피자
				<option value="카페">카페
			</select> <input class="select-keyword round-orange-hover" type="text" name="keyword" id="keyword" placeholder="키워드 입력">
			<button type="submit" class="normal_bigbtn">검색</button>

			<button type="button" class="else_bigbtn" onclick="searchAll();">전체 검색</button>
		</div>


	</div>
</article>


<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


