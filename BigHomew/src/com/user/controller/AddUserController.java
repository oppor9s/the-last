package com.user.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import com.entity.LoginUser;
import com.entity.Order;
import com.entity.UsersAddress;
import com.user.service.AddUserService;
import com.user.service.AdminLoginService;

@Controller
@RequestMapping("/adduser")
public class AddUserController {
@Resource
private AddUserService addUserService;
@Resource
private AdminLoginService adminloginservice;
//邮箱注册
@RequestMapping("/addemail")
public String adduser1(LoginUser loginUser,HttpServletRequest request,HttpServletResponse response,HttpSession s){
	List<LoginUser> list=addUserService.findName(loginUser.getName());
	if(list.size()!=0){
		JOptionPane.showMessageDialog(null, "用户名已存在!");
		return "regster";
	}
	if(loginUser.getName()==null){
		JOptionPane.showMessageDialog(null, "用户名为空!");
		return "regster";
	}
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String date = df.format(new Date());
	loginUser.setUserstate(1);
	addUserService.adduser(loginUser);
	s.setAttribute("name", loginUser.getName());
	Properties prop = System.getProperties();
	prop.put("mail.transport.protocol", "smtp");
	prop.put("mail.smtp.host", "smtp.163.com");
	prop.put("mail.smtp.auth", "true");
	
	Session session = Session.getInstance(prop, new Authenticator() {
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("javamail5678", "javamail5678sqm");
		}
	});
	
	Message msg = new MimeMessage(session);
	try{
		msg.setFrom(new InternetAddress("javamail5678@163.com"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(loginUser.getName()));
		msg.setSubject("邮箱激活");
		MimeBodyPart mimeBodyPart = new MimeBodyPart();
		mimeBodyPart.setContent("<a href='http://localhost:8080/BigHomewoke/adduser/jihuo?name="+loginUser.getName()+"'>点击激活</a>", "text/html;charset=UTF-8");
		MimeMultipart mimeMultipart = new MimeMultipart();
		mimeMultipart.addBodyPart(mimeBodyPart);
		msg.setContent(mimeMultipart);
		msg.setHeader("X-Mailer", "smtpsend");
		msg.setSentDate(new Date());
		Transport.send(msg);
		response.getWriter().print("ok");
		
	}catch(Exception e){
		e.printStackTrace();
	}
	return "index3";
}


@RequestMapping(value="/jihuo",method=RequestMethod.GET)
public String jihuo(@RequestParam("name") String name){
	System.out.println(name);
	List<LoginUser> list = addUserService.findName(name);
	if(list.get(0).getUserstate()!=0){
		//JOptionPane.showMessageDialog(null, "激活成功!");
		return "requestYes";
	}else{
		JOptionPane.showMessageDialog(null, "激活失败!");
		return "error";
	}
	
}
//用户名注册新用户
	@RequestMapping("/add")
	public String adduser(LoginUser loginUser,HttpSession session){
		if(loginUser.getName()==""){
			JOptionPane.showMessageDialog(null,"用户名不能为空！！！");
			return "regster";
		}else{
			if(loginUser.getPassword()==""){
				JOptionPane.showMessageDialog(null,"密码不能为空！！！");
				return "regster";
			}else{
				System.out.println("注册用户");
				System.out.println(loginUser.getName());
				System.out.println(loginUser.getPassword());
				loginUser.setUserstate(1);
				session.setAttribute("name",loginUser.getName());
				addUserService.adduser(loginUser);
				return "index2";
			}
		}
	}
//用户登陆
	//验证用户名
	@RequestMapping("/loginname")
	@ResponseBody
	public String loginnmae(@RequestParam(value="q") String str,HttpSession session){
	//	String name = loginUser.getName();
		List<LoginUser> list=addUserService.findName(str);
		System.out.println("2111212121");
		System.out.println("用户姓名"+str);
		if(list.isEmpty()){
			return "noexist";
		}else{
				System.out.print("用户名存在");
				session.setAttribute("name1",str);
				System.out.println(session.getAttribute("name1"));
				return list.get(0).getPassword();		
		}
	}
	//验证密码
	@RequestMapping("/loginpassword")
	@ResponseBody
	public String loginpassword(@RequestParam(value="q") String str,HttpSession session){
	//	String name = loginUser.getName();
		List<LoginUser> list=addUserService.findName((String) session.getAttribute("name1"));
		
		System.out.println("用户姓名"+session.getAttribute("name1"));
		System.out.println("密码"+list.get(0).getPassword());
		if(str.equals(list.get(0).getPassword())){
			return "";
		}else{
			return "noexist";		
		}
	}
	//登陆跳转页面
	@RequestMapping("/login")
	public String login(HttpSession session,LoginUser user){
	session.setAttribute("name", user.getName());
		return "index2";
	}
	
//邮箱验证
	@RequestMapping()
	public String loginemail(LoginUser loginUser,HttpSession session){
			session.setAttribute("name",loginUser.getName());
			addUserService.adduser(loginUser);
		return "";
	}
//修改个人信息
	@RequestMapping("/usermessage")
	public String message(Model model,HttpSession session){
		String name=(String) session.getAttribute("name");
		if(name==null){
			JOptionPane.showMessageDialog(null,"请先登录。");
			return "redirect:/findproduct/findByPage?pagenum=1";
		}
		List<LoginUser> list1=addUserService.findName((String) session.getAttribute("name"));
		LoginUser user=new LoginUser();
		user.setAddress(list1.get(0).getAddress());
		user.setEmail(list1.get(0).getEmail());
		user.setId(list1.get(0).getId());
		user.setName(list1.get(0).getName());
		user.setPassword(list1.get(0).getPassword());
		user.setPhone(list1.get(0).getPhone());
		model.addAttribute("password0",list1.get(0).getPassword());
		model.addAttribute("user",user);
		List<Order> list2= adminloginservice.findorder((String) session.getAttribute("name"));
		model.addAttribute("list2",list2);
		model.addAttribute("name1",session.getAttribute("name"));
	//查询此用户的所有地址
		List<UsersAddress> list3=addUserService.address((String) session.getAttribute("name"));
		model.addAttribute("list3",list3);
		return "personal";
	}
	//删除用户地址
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="id") int id){
		addUserService.delete(id);
		
		JOptionPane.showMessageDialog(null,"删除成功");
		return "redirect:/adduser/usermessage";
	}
	//修改用户地址
	@RequestMapping(value="/change",method=RequestMethod.POST)
	public String change(UsersAddress address){
		addUserService.change(address);
		JOptionPane.showMessageDialog(null,"修改成功");
		return "redirect:/adduser/usermessage";
	}
	//新增用户地址
	@RequestMapping("/addAddress")
	public String add(UsersAddress address){
		System.out.println(address.getName()+"9000000000000000");
		addUserService.add(address);
		return "redirect:/adduser/usermessage";
	}
	
	
	
//使用ajax验证用户名
	@RequestMapping(value="/check",method=RequestMethod.GET)
	@ResponseBody
	public String checkuser(@RequestParam(value="q") String str){

		List<LoginUser> list= addUserService.findalluser(); 
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getName().equals(str)){
				return "yes";
			}
		}
		 return "ww";
	}
}
