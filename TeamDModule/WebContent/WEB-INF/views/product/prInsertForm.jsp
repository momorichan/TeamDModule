<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ include file="../temp/header.jsp"%>

<article>
	<div class="container">
		<h2>��ǰ ���</h2>
		<p>�����ڰ� ������ ��ǰ�� ����ϴ� �������Դϴ�.</p>
		<form action="" method="post" enctype="multipart/form-data">
			<div class="input-group">
				<span class="input-group-text">��ǰ �̸�</span> <input class="form-control" type="text" id="name" name="name">
			</div>
			<div class="input-group">
				<span class="input-group-text">�̹���01</span> <input class="form-control" type="file" id="image01" name="image01">
			</div>
			<div class="input-group">
				<span class="input-group-text">�̹���02</span> <input class="form-control" type="file" id="image02" name="image02">
			</div>
			<div class="input-group">
				<span class="input-group-text">�̹���03</span> <input class="form-control" type="file" id="image03" name="image03">
			</div>
			<div class="input-group">
				<span class="input-group-text">��� ����</span> <input class="form-control" type="number" id="stock" name="stock">
			</div>
			<div class="input-group">
				<span class="input-group-text">�ܰ�</span> <input class="form-control" type="number" id="price" name="price">
			</div>
			<div class="input-group">
				<span class="input-group-text">��з�ī�װ�</span> <select id="lcategory" name="lcategory" class="form-select">
					<c:forEach var="category" items="${lclist}">
						<option id="lcnum" value="${category.lcnum}">${category.lcname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="input-group">
				<span class="input-group-text">�Һз�ī�װ�</span> <select id="scategory" name="scategory" class="form-select">
					<c:forEach var="category" items="${sclist}">
						<option value="${category.scnum}">${category.scname}</option>
					</c:forEach>
				</select>
			</div>
			<div class="input-group">
				<span class="input-group-text">��ǰ �� ����</span> <input class="form-control" type="text" id="contents" name="contents">
			</div>
			<div id="buttonset" class="input-group">
				<button type="submit" class="btn btn-primary btn-lg" onclick="return validCheck();">���</button>
				&nbsp;&nbsp;&nbsp;
				<button type="reset" class="btn btn-secondary btn-lg">�ʱ�ȭ</button>
			</div>
		</form>
	</div>
</article>
<script>
	$('#lcategory').on('change', function() {
		var selectedValue = $(this).val();
		$.ajax({
			url : "/sclist?lcnum=" + selectedValue,
			type : "get",
			success : function(response) {
				// ���������� �����͸� �޾��� ���� ó��
			},
			error : function(error) {
				// ������ �߻����� ���� ó��
			}
		});
	});
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


