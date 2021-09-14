<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
<link rel="stylesheet" href="./css/style.css">
</head>
<body>


<div class="card" style="width: 100%; height: auto">
<div class="card-header">
	<h5>참고사이트</h5>
	<div class="card-header-right">
		<ul class="list-unstyled card-option">
			<li><i class="icofont icofont-simple-left "></i></li>
			<li><i class="icofont icofont-maximize full-card"></i></li>
			<li><i class="icofont icofont-minus minimize-card"></i></li>
			<li><i class="icofont icofont-refresh reload-card"></i></li>
			<li><i class="icofont icofont-error close-card"></i></li>
		</ul>
	</div>
</div>
<div class="card-block table-border-style">
	<div class="table-responsive">
		<table class="table table-hover">
		<col width="200px"><col width="500px"><col width="100px"><col width="200px">
			<thead>
				<tr>
					<th>사이트명</th><th>참고사항</th><th>대표번호</th><th>사이트바로가기</th>
				</tr>
			</thead>
			<tbody>

				<tr>
					<th scope="row">청소년사이버상담센터</th>
					<td>청소년의 일상적인 고민 상담부터 가출, 학업중단, 인터넷 중독</td>
					<td>(1388)</td>
					<td>
					<button type="button" onclick="location.href='https://www.cyber1388.kr:447/'">바로가기</button>
					</td>
				</tr>
				<tr>
					<th scope="row">국립중앙청소년디딤센터</th>
					<td>ADHD, 불안, 우울 등 심리 정서적 문제, 인터넷(게임) 몰입, 은둔형 외톨이, 학교 부적응 등</td>
					<td>(031-333-1900)</td>
					<td>
					<button type="button" onclick="location.href='http://www.nyhc.or.kr/IndexServlet'">바로가기</button>
					</td>
				</tr>
				<tr>
					<th scope="row">자살예방 생명지킴이</th>
					<td>-</td>
					<td>(02-3706-0424)</td>
					<td>
					<button type="button" onclick="location.href='http://jikimi.spckorea.or.kr/new/main/index.php'">바로가기</button>
					</td>
				</tr>
				<tr>
					<th scope="row">경찰청(범죄 및 자살신고)</th>
					<td>-</td>
					<td>(112)</td>
					<td>
					<button type="button" onclick="location.href='https://www.police.go.kr/index.do'">바로가기</button>
					</td>
				</tr>
				<tr>
					<th scope="row">방송통신심의위원해</th>
					<td>-</td>
					<td>(1377)</td>
					<td>
					<button type="button" onclick="location.href='http://www.kocsc.or.kr/mainPage.do'">바로가기</button>
					</td>
				</tr>
				<tr>
					<th scope="row">학교폭력 신고센터</th>
					<td>-</td>
					<td>(117)</td>
					<td>
					<button type="button" onclick="location.href='http://www.safe182.go.kr/cont/homeContents.do?contentsNm=intro_portal117'">바로가기</button>
					</td>
				</tr>
				
				
			</tbody>
		</table>
	</div>
</div>


</div>
</body>
</html>