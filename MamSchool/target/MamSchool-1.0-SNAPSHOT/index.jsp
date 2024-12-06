<%-- 
    Document   : index
    Created on : 6 Dec 2024, 21.48.50
    Author     : Dafi Utomo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mam</title>
        <!-- Link CSS Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <!-- Link CSS Owl Carousel -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/assets/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body class="text-light" style="background-color: #26335D">

        <!-- Navbar -->
        <nav class="navbar navbar-expand-md navbar-dark shadow sticky-top" style="background-color: #26335D">
            <div class="container-fluid px-3">
                <a class="navbar-brand" href="#">Mam School</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto ">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Product</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Pricing</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Contact</a>
                        </li>
                    </ul>
                    <div class="d-flex ms-auto"> <!-- ms-auto untuk menggeser tombol login ke kanan -->
                        <a class="nav-link btn btn-light text-white px-4 p-2" href="frontEnd/Login.jsp" style="background-color: #8D5CF6;">Login</a>
                    </div>
                </div>
            </div>
        </nav>

        <section class="hero d-flex align-items-center">
            <div class="container py-5">
                <div class="row justify-content-center text-center align-items-center g-3">
                    <div class="col-lg-6 col-12">
                        <!-- Hero Heading with New Text -->
                        <h3 class=" mb-4 text-center text-md-start" style="color: #8D5CF6;">For Better Future</h3>
                        <h1 class="text-white mb-4 fw-bold text-center text-md-start">MAM BOARDING SCHOOL</h1>

                        <!-- New Description / Lead Text -->
                        <p class="lead text-white mb-5 text-start">MAM Boarding School offers a nurturing environment for students to grow and excel. With personalized learning and a focus on holistic development, our school prepares students for a bright future.</p>

                        <!-- Buttons -->
                        <div class="g-3">
                            <a href="#get-quote" class="btn btn-light btn-lg px-4 py-3 fw-bold m-2">Get Quote Now</a>
                            <a href="#learn-more" class="btn btn-outline-light btn-lg px-4 py-3 fw-bold">Learn More</a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-12">
                        <!-- Placeholder Image -->
                        <img src="Image/education.svg" alt="Boarding School Image" class="img-fluid rounded-3" width="400" height="400">
                    </div>
                </div>
            </div>
        </section>

        <!-- Owl Carousel Section with Cards -->
        <section class="container my-5 px-4">
            <h2 class="text-center p-2">Features</h2>
            <div class="owl-carousel owl-theme">
                <div class="item">
                    <div class="card" style="min-height: 400px;">
                        <img src="Image/education.svg" class="card-img-top" alt="Education Image">
                        <div class="card-body">
                            <h5 class="card-title">Personalized Education</h5>
                            <p class="card-text flex-grow-1">Our curriculum is tailored to each student's unique learning needs, ensuring that they excel in every area.</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="card" style="min-height: 400px;">
                        <img src="Image/education.svg" class="card-img-top" alt="Education Image">
                        <div class="card-body">
                            <h5 class="card-title">Expert Mentorship</h5>
                            <p class="card-text flex-grow-1">Learn from experienced mentors who guide you through your academic journey, providing expert advice and support.</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="card" style="min-height: 400px;">
                        <img src="Image/education.svg" class="card-img-top" alt="Education Image">
                        <div class="card-body">
                            <h5 class="card-title">Engaging Curriculum</h5>
                            <p class="card-text flex-grow-1">Our interactive curriculum is designed to make learning fun and effective, helping students master concepts with ease.</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="card" style="min-height: 400px;">
                        <img src="Image/education.svg" class="card-img-top" alt="Education Image">
                        <div class="card-body">
                            <h5 class="card-title">Leadership Development</h5>
                            <p class="card-text flex-grow-1">We cultivate leadership qualities in our students through practical experiences and community involvement.</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="card" style="min-height: 400px;">
                        <img src="Image/education.svg" class="card-img-top" alt="Education Image">
                        <div class="card-body">
                            <h5 class="card-title">Comprehensive Student Support</h5>
                            <p class="card-text flex-grow-1">Our dedicated support staff is available to help students with academic, personal, and emotional needs.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Program Sekolah -->
        <section class="container my-5">
            <h2 class="text-center p-2 text-white">Our Programs</h2>
            <div class="row">
                <!-- Program 1: Beasiswa -->
                <div class="col-lg-6 col-md-12 d-flex align-items-center mb-4">
                    <div class="row w-100">
                        <div class="col-md-6">
                            <div class="card bg-transparent border-0">
                                <img src="Image/belajar.svg" class="img-fluid" alt="Beasiswa Program">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-body">
                                <h5 class="card-title">Beasiswa Program</h5>
                                <p class="card-text">MAM Boarding School offers various scholarship programs to help deserving students achieve their dreams. We believe in providing opportunities to excel without financial constraints.</p>
                                <a href="#" class="btn btn-outline-light">Learn More</a>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- Program 2: Program Umroh -->
                <div class="col-lg-6 col-md-12 d-flex align-items-center mb-4 ">
                    <div class="row w-100">
                        <div class="col-md-6">
                            <div class="card bg-transparent border-0">
                                <img src="Image/travel.svg" class="card-img-top" alt="Umroh Program">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-body">
                                <h5 class="card-title">Program Umroh</h5>
                                <p class="card-text">We offer a unique program that allows students to embark on a spiritual journey to Umroh as part of their personal development. This program is designed to foster both educational and spiritual growth.</p>
                                <a href="#" class="btn btn-outline-light">Learn More</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Program 3: Program Kewirausahaan -->
                <div class="col-lg-6 col-md-12 d-flex align-items-center mb-4">
                    <div class="row w-100">
                        <div class="col-md-6">
                            <div class="card bg-transparent border-0">
                                <img src="Image/bussiness.svg" class="card-img-top" alt="Kewirausahaan Program">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-body">
                                <h5 class="card-title">Program Kewirausahaan</h5>
                                <p class="card-text">Our Entrepreneurship Program helps students develop skills for starting and managing businesses. This program equips students with the knowledge and skills they need to succeed in the business world.</p>
                                <a href="#" class="btn btn-outline-light">Learn More</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Program 4: Program Pendidikan Lanjutan -->
                <div class="col-lg-6 col-md-12 d-flex align-items-center mb-4 rounded">
                    <div class="row w-100">
                        <div class="col-md-6">
                            <div class="card bg-transparent border-0">
                                <img src="Image/family.svg" class="card-img-top" alt="Pendidikan Lanjutan Program">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card-body">
                                <h5 class="card-title">Program Pendidikan Lanjutan</h5>
                                <p class="card-text">We support students who wish to continue their education to higher levels by offering guidance and financial support for further studies. Our goal is to help students prepare for university and beyond.</p>
                                <a href="#" class="btn btn-outline-light">Learn More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer Section -->
        <footer class="bg-dark text-light py-5">
            <div class="container">
                <div class="row">
                    <!-- About Us Section -->
                    <div class="col-lg-4 col-md-6 mb-4">
                        <h5 style="color: #8D5CF6;">About MAM Boarding School</h5>
                        <p>At MAM Boarding School, we focus on holistic education that nurtures both the mind and the spirit. We offer a supportive learning environment with various programs aimed at the development of our students.</p>
                    </div>

                    <!-- Quick Links Section -->
                    <div class="col-lg-4 col-md-6 mb-4">
                        <h5 style="color: #8D5CF6;">Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="#" class=" link-light link-offset-2 link-underline-opacity-0 link-underline-opacity-100-hover">Home</a></li>
                            <li><a href="#" class=" link-light link-offset-2 link-underline-opacity-0 link-underline-opacity-100-hover">Programs</a></li>
                            <li><a href="#" class=" link-light link-offset-2 link-underline-opacity-0 link-underline-opacity-100-hover">Admissions</a></li>
                            <li><a href="#" class=" link-light link-offset-2 link-underline-opacity-0 link-underline-opacity-100-hover">Contact Us</a></li>
                        </ul>
                    </div>

                    <!-- Contact Information Section -->
                    <div class="col-lg-4 col-md-12 mb-4">
                        <h5 style="color: #8D5CF6;">Contact Us</h5>
                        <p><i class="bi bi-geo-alt"></i> Jl. Pendidikan No. 1, MAM City</p>
                        <p><i class="bi bi-telephone"></i> +62 123 456 789</p>
                        <p><i class="bi bi-envelope"></i> info@mamschool.edu</p>
                    </div>
                </div>

                <!-- Social Media Section -->
                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <a href="#" class="text-light mx-2"><i class="bi bi-facebook fs-3"></i></a>
                        <a href="#" class="text-light mx-2"><i class="bi bi-twitter fs-3"></i></a>
                        <a href="#" class="text-light mx-2"><i class="bi bi-instagram fs-3"></i></a>
                        <a href="#" class="text-light mx-2"><i class="bi bi-linkedin fs-3"></i></a>
                    </div>
                </div>
            </div>

            <!-- Footer Bottom Section -->
            <div class="text-center py-3">
                <p>&copy; 2024 MAM Boarding School. All rights reserved.</p>
            </div>
        </footer>


        <!-- Link JS Bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

        <!-- Link JS Owl Carousel -->
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/owl.carousel.min.js"></script>

        <script>
            $(document).ready(function () {
                $(".owl-carousel").owlCarousel({

                    loop: true,
                    margin: 10,
                    nav: false,
                    autoplay: true,
                    autoplayTimeout: 2000,
                    autoplayHoverPause: true,
                    responsive: {
                        0: {
                            items: 1
                        },
                        600: {
                            items: 3
                        },
                        1000: {
                            items: 4
                        }
                    }
                });
            });
        </script>
    </body>
</html>
