<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Footer Start -->
<footer class="bg-dark text-white mt-5 pt-4 pb-3">
    <div class="container">
        <div class="row">

            <!-- About Section -->
            <div class="col-md-4 mb-4">
                <h5 class="fw-bold">EasyDeals</h5>
                <p class="small">
                    Your one-stop online shopping platform for electronics, fashion, and groceries.
                    We bring quality products with the best offers, right at your fingertips.
                </p>
            </div>

            <!-- Quick Links -->
            <div class="col-md-4 mb-4">
                <h5 class="fw-bold">Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="product.jsp" class="text-white text-decoration-none">Products</a></li>
                    <li><a href="about.jsp" class="text-white text-decoration-none">About Us</a></li>
                    <li><a href="contact.jsp" class="text-white text-decoration-none">Contact</a></li>
                </ul>
            </div>

            <!-- Contact & Socials -->
            <div class="col-md-4 mb-4">
                <h5 class="fw-bold">Contact Us</h5>
                <p class="small mb-1"><i class="fa-solid fa-location-dot me-2"></i> Mumbai, India</p>
                <p class="small mb-1"><i class="fa-solid fa-phone me-2"></i> +91 9876543210</p>
                <p class="small mb-3"><i class="fa-solid fa-envelope me-2"></i> support@easydeals.com</p>

                <div>
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin fa-lg"></i></a>
                </div>
            </div>

        </div>
        <hr class="border-light">
        <div class="text-center small">
            &copy; <%= new java.util.Date().getYear() + 1900 %> EasyDeals. All Rights Reserved.
        </div>
    </div>
</footer>
<!-- Footer End -->
