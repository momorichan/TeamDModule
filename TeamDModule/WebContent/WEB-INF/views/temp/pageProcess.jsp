<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- temp/pageProcess.jsp --%>
<c:set var="pageurl" value="?num=${num}&searchType=${searchType}&searchValue=${searchValue}&cPage" />
		<ul class="pagination" style="margin: 0 auto; width: 35%">
			<%-- 이전페이지 --%>
			<c:choose>
				<c:when test="${startPage <= page.pagePerBlock }">
					<li class="page-item disabled">
					<a class="page-link" href="#">Previous</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item active"><a class="page-link"
						href="${pageurl }=${startPage -1 }"> Previous </a></li>
				</c:otherwise>
			</c:choose>
			<%-- 현재 페이지 startPage, endPage--%>
			<%--nowPage 에 해당이 되지 않으면 링크를 걸어서 페이지 메뉴 선택 제공--%>
			<c:forEach varStatus="i" begin="${startPage }" end="${endPage }">
				<%--현재 페이지면 링크를 해제 , 링크를 지정 --%>
				<c:choose>
					<c:when test="${i.index == page.nowPage }">
						<li class="page-item active"><a class="page-link" href="#">${i.index }</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${pageurl }=${i.index }">${i.index }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<%-- 다음페이지 --%> 
			<c:choose>
				<c:when test="${endPage >= page.totalPage }">
				<li class="page-item disabled"><a class="page-link" href="#">
				Next
				</a></li>
				</c:when>
				<c:otherwise>
				<li class="page-item active">
					<a href="${pageurl }=${endPage + 1 }" class="page-link"> Next </a>
				</li>
				</c:otherwise>
			</c:choose>
		</ul>
