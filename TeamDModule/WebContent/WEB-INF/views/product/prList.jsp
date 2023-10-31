<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@include file="../temp/header.jsp"%> --%>
<style>
.searchCls {
	color:red;
}
    /* Header Style with Rainbow and Twinkle Effect */
    header {
        font-size: 24px;
        font-weight: bold;
        background: linear-gradient(45deg, #ff0000, #ff9900, #33cc33, #0099cc, #9933cc, #ff00ff);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        animation: twinkle 2s ease-in-out infinite;
    }

    @keyframes twinkle {
        0%, 100% {
            color: transparent;
            text-shadow: none;
        }
        10%, 90% {
            color: #fff;
            text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 20px #ff00ff, 0 0 30px #ff00ff, 0 0 40px #ff00ff, 0 0 50px #ff00ff, 0 0 60px #ff00ff;
        }
    }

    /* Table Style */
    .table th {
        background-color: #f2f2f2;
        color: #333;
        padding: 12px;
    }

    .table tbody tr:hover {
        background-color: #e0e0e0;
    }

    .table tbody tr td {
        padding: 10px;
        text-align: center;
    }

    /* Button Style */
    .btn-mini {
        padding: 8px 16px;
        font-size: 16px;
        background: linear-gradient(45deg, #ff0000, #ff9900, #33cc33, #0099cc, #9933cc, #ff00ff);
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
</style>
<article>
    <header>File Upload Demo</header>
    <ul class="list-unstyled">
<!--         <li class="border-top my-3">File List</li> -->
    </ul>
    <div class="container">
        <table class="table table-bordered" id="upboardTable">
            <thead>
                <tr>
                    <th colspan="6">
                        <select id="sv" name="sv" class="btn-mini">
                            <option value="0">Search</option>
                            <option value="1">Hit</option>
                            <option value="2">Date</option>
                        </select>
                    </th>
                </tr>
                <tr>
                    <th>번호</th>
                    <th>상품 이름</th>
                    <th>가격</th>
                    <th>재고</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vo" items="${list}">
                    <tr>
                        <td>${vo.pnum}</td>
                        <td>
<%--                             <a href="upBoardDetail?num=${vo.num}"> --%>
<%--                                 <img src="${rPath}/imgfile/${vo.imgn}" style="width: 80px; cursor: pointer;"> --%>
<!--                             </a> -->
                        </td>
                        <td>${vo.pname}</td>
                        <td>${vo.stock}</td>
                        <td>${vo.price}</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="6">
                        <form class="d-flex" method="post" action="upList">
                            <select class="form-control btn-mini" name="searchType" id="searchType">
                                <option value="">클릭</option>
                                <option value="1">글제목</option>
                                <option value="2">작성자</option>
                                <option value="3">내용</option>
                            </select>
                            <input class="form-control me-2" type="text" placeholder="Search.." name="searchValue" id="searchValue">
                            <button class="btn btn-mini" type="submit">Search</button>
                        </form>
                    </th>
                </tr>
                <tr>
                    <td colspan="6" style="text-align: right; ">
                    	<%@include file="../temp/pageProcess.jsp"%>
                        <button type="button" class="btn btn-mini" onclick="location='upform'">Write</button>
                    </td>
                </tr>
                
            </tfoot>
        </table>
		
    </div>
</article>
<%-- <%@include file="../temp/footer.jsp"%> --%>
