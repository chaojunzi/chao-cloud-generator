package com.chao.cloud.generator.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chao.cloud.common.config.web.HealthController;
import com.chao.cloud.common.config.web.HealthController.CoreParam;
import com.chao.cloud.common.util.EntityUtil;
import com.chao.cloud.generator.constant.XcConstant;
import com.chao.cloud.generator.dal.entity.XcConfig;
import com.chao.cloud.generator.dal.entity.XcGroup;
import com.chao.cloud.generator.domain.dto.LoginDTO;
import com.chao.cloud.generator.domain.dto.MenuDTO;
import com.chao.cloud.generator.domain.dto.MenuLayuiDTO;
import com.chao.cloud.generator.service.XcConfigService;
import com.chao.cloud.generator.service.XcGroupService;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.io.resource.ResourceUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;

/**
 * @功能：
 * @author： 超君子
 * @时间：2019-07-23
 * @version 1.0.0
 */
@RequestMapping
@Controller
@Validated
public class IndexController extends BaseController {
	@Autowired
	private XcConfigService xcConfigService;
	@Autowired
	private XcGroupService xcGroupService;

	/**
	 * 首页
	 * @param m
	 * @param session
	 * @return
	 */
	@RequestMapping({ "", "/", "/index" })
	String generator(Model m, HttpSession session) {
		List<XcGroup> groups = xcGroupService.list();
		List<MenuDTO> list = EntityUtil.listConver(groups, MenuDTO.class);
		if (CollUtil.isNotEmpty(list)) {
			List<XcConfig> configs = xcConfigService.list();
			// 分组转换
			if (CollUtil.isNotEmpty(configs)) {
				Map<Integer, List<XcConfig>> map = configs.stream()
						.collect(Collectors.groupingBy(XcConfig::getGroupId));
				// 遍历list
				list.forEach(l -> l.setConfigs(EntityUtil.listConver(map.get(l.getId()), MenuDTO.Config.class)));
			}
		}
		m.addAttribute("menus", list);
		// 判断是否为管理员
		LoginDTO user = getUser(session);
		if (XcConstant.ADMIN_USER_NAME.contains(user.getUserName())) {
			m.addAttribute("admin_menu", XcConstant.ADMIN_MENU);
		}
		return "index";
	}

	/**
	 * 主页面
	 * @return
	 */
	@RequestMapping("main")
	String main(Model m) {
		CoreParam core = HealthController.coreParam();
		m.addAttribute("core", core);
		return "main";
	}

	/**
	 * 系统左侧导航菜单
	 * @return
	 */
	@RequestMapping("/menu/leftList")
	@ResponseBody
	public List<MenuLayuiDTO> leftList() {
		// 加载基础菜单
		String json = ResourceUtil.readUtf8Str("public/json/menu.json");
		List<MenuLayuiDTO> menus = JSONUtil.toList(JSONUtil.parseArray(json), MenuLayuiDTO.class);
		//
		List<XcGroup> list = xcGroupService.list();
		int id = 1;
		if (CollUtil.isNotEmpty(list)) {
			for (XcGroup g : list) {
				menus.add(buildMenu(XcConstant.TOP_ID, g.getId(), XcConstant.TOP_ICON, g.getName(), null));
				if (id < g.getId()) {
					id = g.getId();
				}
			}
			id++;
		}
		List<XcConfig> configs = xcConfigService.list();
		if (CollUtil.isNotEmpty(configs)) {
			for (XcConfig c : configs) {
				menus.add(buildMenu(c.getGroupId(), id++, XcConstant.CHILDREN_ICON, c.getTitle(),
						StrUtil.format(XcConstant.HREF_TEMPLATE, c.getId())));
			}
		}
		// 递归
		return EntityUtil.toTreeAnnoList(menus, XcConstant.TOP_ID);
	}

	private MenuLayuiDTO buildMenu(Integer parentId, Integer menuId, String icon, String title, String href) {
		return MenuLayuiDTO.of()//
				.setMenuId(menuId)//
				.setParentId(parentId)//
				.setIcon(icon)//
				.setTitle(title)//
				.setHref(href);
	}

}