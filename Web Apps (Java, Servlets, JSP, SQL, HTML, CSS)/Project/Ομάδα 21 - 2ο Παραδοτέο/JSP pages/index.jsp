<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html>
<div class="title">
<head>
  <title>Kidzland</title>
  <%@ include file="header.jsp"%>
  <link rel="stylesheet" type="text/css" href="index.css">
</head>

 <body>
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <h1 id="quote">Οι καλύτερες εκδηλώσεις στη πόλη!</h1>
            <a href="results.jsp" class="btn btn-warning" type="button" id="search">Αναζήτηση</a>
        </div>
      </div>
      <div class="row">
          <div class="col-lg-12">
            <h3>Πρόσφατες Εκδηλώσεις</h3>
            <div class="grid grid-pad">
              <div class="col-1-4">
                <div class="module event">
                  <a href="eventpage.jsp">
                    <h4>ΤΑΙΝΙΑ ΤΟ ΓΑΤΟΞΟΡΚΙ</h4>
                    <img class="card-img-top" id="image" src="images/cat.jpg" alt="Card image">
                  </a>
                </div>
              </div>
              <div class="col-1-4">
                <div class="module event">
                    <h4>ΡΟΜΠΕΝ ΤΩΝ ΔΑΣΩΝ</h4>
                    <img class="card-img-top" id="image" src="images/roben.jpg" alt="Card image">
                </div>
              </div>
              <div class="col-1-4">
                <div class="module event">
                    <h4>ΜΟΥΣΙΚΗ ΓΙΑ ΠΑΙΔΙΑ</h4>
                    <img class="card-img-top" id="image" src="images/jazz.jpg" alt="Card image">
                </div>
              </div>
              <div class="col-1-4">
                <div class="module event">
                    <h4>ΝΕΟΣ ΠΑΙΔΟΤΟΠΟΣ</h4>
                    <img class="card-img-top" id="image" src="images/img8.jpg" alt="Card image">
                </div>
              </div>
            </div>
          </div>
      </div>
    </div>
 </body>
</div>
<%@ include file="footer.jsp"%>

</html>
