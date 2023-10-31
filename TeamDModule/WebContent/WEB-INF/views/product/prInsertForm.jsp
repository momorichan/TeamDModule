<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ include file = "../temp/header.jsp"%>

<article>
   <div class="container">
      <h2>��ǰ ���</h2>
      <p>�����ڰ� ������ ��ǰ�� ����ϴ� �������Դϴ�.</p>
      <form action="" method="post" enctype="multipart/form-data">
         <div class="input-group">
            <span class="input-group-text">��ǰ �̸�</span>
            <input class="form-control" type="text" id="name" name="name">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�̹���01</span>
            <input class="form-control" type="file" id="image01" name="image01">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�̹���02</span>
            <input class="form-control" type="file" id="image02" name="image02">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�̹���03</span>
            <input class="form-control" type="file" id="image03" name="image03">            
         </div>
         <div class="input-group">
            <span class="input-group-text">��� ����</span>
            <input class="form-control" type="number" id="stock" name="stock">            
         </div>
         <div class="input-group">
            <span class="input-group-text">�ܰ�</span>
            <input class="form-control" type="number" id="price" name="price">            
         </div>
         <div class="input-group">
            <span class="input-group-text">��з�ī�װ�</span>
            <select id="lcategory" name="lcategory" class="form-select">
               <c:forEach var="category" items="${lclist}"> 
                  <option value="${category.lcnum}">${category.lcname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">�Һз�ī�װ�</span>
            <select id="scategory" name="scategory" class="form-select">
               <c:forEach var="category" items="${sclist}"> 
                  <option value="${category.scnum}">${category.scname}</option>
               </c:forEach>
            </select>            
         </div>
         <div class="input-group">
            <span class="input-group-text">��ǰ �� ����</span>
            <input class="form-control" type="text" id="contents" name="contents">            
         </div>         
         <div id="buttonset" class="input-group">
            <button type="submit" class="btn btn-primary btn-lg"
               onclick="return validCheck();">���
            </button>
            &nbsp;&nbsp;&nbsp;
            <button type="reset" class="btn btn-secondary btn-lg">�ʱ�ȭ</button>
         </div>
      </form>
   </div>
</article>
<script>
$.ajax({ // ajax �⺻����
	//////////////////// send(���°�)
	url : "data.jsp",
	type : "get",
//	data : "t1=XYZ&t2=����ī", // �Ѱ��ִ� ������
	data : {t1:"xyz", t2:"������"}, //���͵���

	//////////////////// recv
	success : function(data, status, xhr){ // status, xhr �������� 

	//	alert("success"); // �����ϸ�  success
	//	alert(data);
	
		$("#demo").html(data);
	//	alert(status);  // ���¸� ��ȯ�Ѵ� (success)
	//	alert(xhr.responseText); // html���� ���� ��ü�� ����Ѵ�.
	},
	error : function(xhr, status, error) { // (�Ķ���� ��������)
		alert("error");
	},
	complete : function(xhr, status) { // (�Ķ���� ��������)
		alert("�������");
	}
	////////////////////
});	



	window.onload = function() {
		let number = 1;
		document.querySelector("#load1").onclick = function(e) {
			e.preventDefault();
			let param = null;
			sendRequest("boardJsonList", param, res, "get");
		}
		document.querySelector("#sendAjax").onclick = function(e) {
			e.preventDefault();
			//�������� ������ ��ü
			/*
			num:1,
			title:"������ ���� ����������0",
			writer:"��浿",
			content:"����1",
			reip:"192.168.0.113",
			bdate:"2023-06-14"
			 */
			const data = {}
			data.num = number;
			data.title = document.getElementById("title").value;
			data.content = document.getElementById("content").value;
			data.writer = document.getElementById("writer").value;
			data.reip = document.getElementById("reip").value;
			data.bdate = "2023-06-14";
			let param = JSON.stringify(data); //json���� ��ȯ
			let type = "json";
			//alert(data.bdate);
			sendRequest("RequestParamDemo", param, res2, "post", type);
			number++;
		}
		//callback
		function res() {
			if(xhr.readyState === 4){
				if(xhr.status === 200){
					$('#target').empty();
					let res = xhr.responseText;
					console.log("res =>"+ res);
					let data = JSON.parse(xhr.responseText);
					dataListLoad(data);
				}
			}
		}
		
		function dataListLoad(data) {
			data.forEach(item => {
		        var tr = $('<tr>');
		        
		        
		        
		        tr.append($('<td>').text(item.num));
		        tr.append($('<td>').text(item.title));
		        tr.append($('<td>').text(item.writer));
		        tr.append($('<td>').text(item.reip));
		        tr.append($('<td>').text(item.bdate));

		        $('#target').append(tr);
		    });
		}
		
		function res2() {
			if(xhr.readyState === 4){
				if(xhr.status === 200){
					let res = xhr.responseText;
					console.log("res2 =>"+ res);
				}
			}
		}
	}
</script>