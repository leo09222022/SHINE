<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.emerlet.vo.ToiletVO" %>
<%
    ToiletVO toilet = (ToiletVO) request.getAttribute("toilet");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>화장실 정보 오류 신고</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        .container {
            max-width: 700px;
            margin: auto;
        }

        h2 {
            color: #3A81FF;
        }

        .section {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        .btn {
            background: #3A81FF;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #2d6cd6;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        .radio-group {
            display: flex;
            gap: 10px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>화장실 정보 오류 신고</h2>

    <div class="section">
        <label>화장실명</label>
        <div><%= toilet.getName() %></div>
    </div>

    <div class="section">
        <label>도로명 주소</label>
        <div><%= toilet.getAddressRoad() %></div>
    </div>

    <form action="toiletReportSubmit.do" method="post">
        <input type="hidden" name="toilet_id" value="<%= toilet.getToiletId() %>"/>

        <div class="section">
            <label>남자화장실</label>
            <div class="radio-group">
                <label><input type="radio" name="userMaleToilet" value="Y"> 있음</label>
                <label><input type="radio" name="userMaleToilet" value="N"> 없음</label>
                <label><input type="radio" name="userMaleToilet" value="U" checked> 모름</label>
            </div>
        </div>

        <div class="section">
            <label>여자화장실</label>
            <div class="radio-group">
                <label><input type="radio" name="userFemaleToilet" value="Y"> 있음</label>
                <label><input type="radio" name="userFemaleToilet" value="N"> 없음</label>
                <label><input type="radio" name="userFemaleToilet" value="U" checked> 모름</label>
            </div>
        </div>

        <div class="section">
            <label>장애인화장실</label>
            <div class="radio-group">
                <label><input type="radio" name="userDisabledToilet" value="Y"> 있음</label>
                <label><input type="radio" name="userDisabledToilet" value="N"> 없음</label>
                <label><input type="radio" name="userDisabledToilet" value="U" checked> 모름</label>
            </div>
        </div>

        <div class="section">
            <label>기저귀 교환대</label>
            <div class="radio-group">
                <label><input type="radio" name="userHasDiaperTable" value="Y"> 있음</label>
                <label><input type="radio" name="userHasDiaperTable" value="N"> 없음</label>
                <label><input type="radio" name="userHasDiaperTable" value="U" checked> 모름</label>
            </div>
        </div>

        <div class="section">
            <label>기타 설명</label>
            <textarea name="userDescription" rows="4" placeholder="오류에 대한 추가 설명을 입력해주세요."></textarea>
        </div>

        <div class="section">
            <label>사진 오류 여부</label>
            <div class="radio-group">
                <label><input type="radio" name="photoError" value="O"> O</label>
                <label><input type="radio" name="photoError" value="X" checked> X</label>
            </div>
        </div>

        <div class="section">
            <button type="submit" class="btn">신고 제출</button>
        </div>
    </form>
</div>
</body>
</html>
