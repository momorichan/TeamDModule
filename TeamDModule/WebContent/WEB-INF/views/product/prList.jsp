<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jstl �߰� -->
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
					<th>��ȣ</th>
					<th>�̹���</th>
					<th>��ǰ�̸�</th>
					<th>����</th>
				</tr>
			</thead>
			<tbody>
				<%-- for start 
            ${vo.�Ӽ� } , ${map.key }
            List<BoardVO> list => BoardVO => e
            --%>
				<c:forEach var="e" items="${list}">
					<tr>
						<!-- <th>��ȣ</th> -->
						<th scope="row">${e.pnum}</th>

						<td>${e.pname}</td>
						<td><fmt:formatNumber type="number" value="${e.price}" pattern="###,###" /></td>
					</tr>
				</c:forEach>
				<%-- for end --%>
			</tbody>
			<tfoot>
				<%-- page���� --%>
				<%@include file="../temp/pageProcess.jsp"%>
				<%-- �˻����� --%>
				<tr>
					<th colspan="6">
						<%-- ������ ����Ʈ �𵨷� ��û�� ������. --%>
						<form class="d-flex" method="post" action="prList">
							<input class="form-control me-2" type="text" placeholder="Search.." name="searchValue" id="searchValue" style="width: 300px">
							<button class="btn btn-outline-secondary" type="submit">Search</button>
						</form>
					</th>
				</tr>
				<tr>
					<td colspan="6" style="text-align: right;">
						<button type="button" class="btn btn-outline-secondary" onclick="location='upform'">���ۼ�</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</article>


<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


