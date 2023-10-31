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
						<form class="d-flex" method="post" action="uplist">
							<select class="form-control btn-mini" name="searchType" id="searchType" style="margin-left: 120px;">
								<option value="">�˻�</option>
								<option value="1">��ǰ��</option>
								<option value="2">ī�װ�</option>
							</select> <input class="form-control me-2" type="text" placeholder="Search.." name="searchValue" id="searchValue" style="width: 300px">
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



		<div class="searchArea">
			<input type="hidden" name="command" value="stList"> <select class="select-mode round-orange-hover" id="mode" name="mode">
				<option value="all" selected="selected">������ �ּ���
				<option value="stname">���Ը�
				<option value="category">ī�װ�
			</select> <select class="select-cate round-orange-hover" id="categoryList" name="categoryList">
				<option value="all" selected="selected">ī�װ� ����Ʈ
				<option value="���">���
				<option value="�߽�">�߽�
				<option value="�Ͻ�">�Ͻ�
				<option value="�ѽ�">�ѽ�
				<option value="�н�ƮǪ��">�н�ƮǪ��
				<option value="ġŲ">ġŲ
				<option value="����">����
				<option value="ī��">ī��
			</select> <input class="select-keyword round-orange-hover" type="text" name="keyword" id="keyword" placeholder="Ű���� �Է�">
			<button type="submit" class="normal_bigbtn">�˻�</button>

			<button type="button" class="else_bigbtn" onclick="searchAll();">��ü �˻�</button>
		</div>


	</div>
</article>


<style>
.searchCls {
	color: orange;
	font-weight: bold;
}
</style>


