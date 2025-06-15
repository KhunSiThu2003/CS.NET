<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" 
    AutoEventWireup="true" CodeBehind="Contact.aspx.cs" 
    Inherits="JobFinder.User.Contact" 
    ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="slider-area ">
        <div class="single-slider section-overly slider-height2 d-flex align-items-center" data-background="../assets/img/hero/about.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="hero-cap text-center">
                            <h2>Contact us</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Hero Area End -->
    <!-- ================ contact section start ================= -->
    <section class="contact-section">
        <div class="container">

            <div class="row">
                <div class="col-12">
                    <h2 class="contact-title">Get in Touch</h2>
                </div>

                <div class="col-lg-8">

                    <!-- Add this message panel -->
                    <asp:Panel ID="messagePanel" runat="server" Visible="false" CssClass="alert alert-success">
                        <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                    </asp:Panel>

                    <!-- Send Contact Form Container -->

                    <div class="form-contact contact_form">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="txtName">Your Name <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                        placeholder="Enter your name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                        ControlToValidate="txtName" ErrorMessage="Name is required"
                                        Display="Dynamic" CssClass="text-danger" ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="txtEmail">Email Address <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"
                                        placeholder="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Email is required"
                                        Display="Dynamic" CssClass="text-danger" ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Invalid email format"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        Display="Dynamic" CssClass="text-danger" ValidationGroup="ContactForm"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="txtSubject">Subject</label>
                                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"
                                        placeholder="Enter Subject"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="txtMessage">Message <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine"
                                        CssClass="form-control w-100" Columns="30" Rows="9"
                                        placeholder="Enter your message here"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMessage" runat="server"
                                        ControlToValidate="txtMessage" ErrorMessage="Message is required"
                                        Display="Dynamic" CssClass="text-danger" ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mt-3">
                            <asp:Button ID="btnSubmit" runat="server" Text="Send Message"
                                CssClass="button button-contactForm boxed-btn"
                                OnClick="SubmitForm" ValidationGroup="ContactForm" />
                            <asp:ValidationSummary ID="vsContactForm" runat="server"
                                ShowSummary="false" ShowMessageBox="true"
                                HeaderText="Please correct the following errors:"
                                ValidationGroup="ContactForm" />
                        </div>
                    </div>


                </div>
                <div class="col-lg-3 offset-lg-1">
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="ti-home"></i></span>
                        <div class="media-body">
                            <h3>Buttonwood, California.</h3>
                            <p>Rosemead, CA 91770</p>
                        </div>
                    </div>
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="ti-tablet"></i></span>
                        <div class="media-body">
                            <h3>+1 253 565 2365</h3>
                            <p>Mon to Fri 9am to 6pm</p>
                        </div>
                    </div>
                    <div class="media contact-info">
                        <span class="contact-info__icon"><i class="ti-email"></i></span>
                        <div class="media-body">
                            <h3>support@colorlib.com</h3>
                            <p>Send us your query anytime!</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-none d-sm-block">
                <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d6911.575727935873!2d97.5998977!3d16.837767499999998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e1!3m2!1sen!2smm!4v1749975638133!5m2!1sen!2smm" width="100%" height="600" style="border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>

        </div>
    </section>
    <!-- ================ contact section end ================= -->

</asp:Content>
