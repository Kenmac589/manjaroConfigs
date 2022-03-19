"use strict";(self.webpackChunknotion_next=self.webpackChunknotion_next||[]).push([[370],{93683:(e,t,i)=>{i.r(t),i.d(t,{default:()=>Ze});var o=i(98135),r=i.n(o),n=i(59713),s=i.n(n),a=(i(33948),i(85827),i(15306),i(67294)),d=i.n(a),l=i(15070),c=i(8848),h=i(3779),g=i(56589),u=i(82036),p=i(4615),m=i(89101),S=i(77420),v=i(9844),y=i(9852),f=i(90965),k=i(97880),w=i(82990),b=i(5366),P=i(36110),M=i(26111),A=i(29974),x=i(21325),I=i(38755),Z=i(1643),C=i(64215),z=i(27832),T=i(90031),B=i(62213),N=i(78291),_=i(12318),F=i(72693),E=i(66832),L=i(42402),W=i(68932),R=i(67154),U=i.n(R),V=i(27006),D=i(21202),O=i(28020),j=i(81997),q=i(9714),H=i(48762),Y=i(82970),G=i(62727),K=i(25584),J=i(28452),Q=i(40039),$=i(79029),X=i(14694);class ee extends J.Z{renderComponent(){const{isMobile:e,nestingLevel:t}=this.props;return d().createElement(H.Z,U()({},this.props,{title:r()(X.Z,{childrenStyle:ee.sidebarChildrenStyle,left:this.renderLeftCheckbox(),icon:this.renderIcon(),isMobile:e,style:{marginLeft:8*t}},void 0,this.renderTitle())}))}renderLeftCheckbox(){return r()(Y.Z,{size:16,checked:this.props.isChecked,onClick:this.props.onClick})}renderIcon(){const{store:e,isMobile:t}=this.props,i=e.getIcon();return r()(Q.Z,{disabled:!0,icon:i,title:void 0,isEmptyPage:e.isEmptyPage(),size:t?24:20,pageIconStyle:{fill:this.theme.mediumIconColor}})}renderTitle(){return r()($.Z,{store:this.props.store})}}s()(ee,"sidebarChildrenStyle",{display:"flex",alignItems:"center"});const te=ee;var ie=i(59054),oe=i(31299),re=i(58879),ne=i(78948),se=i(71202),ae=i(16328),de=i(24042),le=i(83071);function ce(e){const{spaceId:t,onSelectPage:i,query:o,source:n,findSelectedBlockAncestorId:s}=e,a=(0,re.O7)();let l=null;const[{status:c,value:h}]=(0,ie.r5)((async()=>await oe.kz({environment:a,query:o,limit:10,requireEditPermissions:!0,spaceId:t,excludeTemplates:!0,source:n})),[a,o,t,n],{debounce:oe.vp});if("idle"===c||"pending"===c)l=r()(le.Z,{},void 0,r()(ne.Z,{}));else{const e=((null==h?void 0:h.results)||[]).map((e=>{let{id:t}=e;const o=new q.Z(a,{table:D.iU,id:t});return function(e){const{store:t,environment:i,alreadySelectedAncestorId:o,onSelectPage:n}=e;if(o&&o===t.id)return{key:t.id,action:()=>{},render:e=>d().createElement(de.Z,U()({},e,{store:t,hidePath:!0,disabled:!0,style:{opacity:.5},caption:r()(b.FormattedMessage,{id:"oauthPageSearchResults.disabledResult.bySelf.message",defaultMessage:"Already added"})}))};if(o){const e=new q.Z(i,{table:D.iU,id:o});return{key:t.id,action:()=>{},render:i=>d().createElement(de.Z,U()({},i,{store:t,hidePath:!0,disabled:!0,style:{opacity:.5},caption:r()(b.FormattedMessage,{id:"oauthPageSearchResults.disabledResult.byAncestor.message",defaultMessage:"Already added via {ancestorPageName}",values:{ancestorPageName:r()($.Z,{store:e,style:{display:"inline"}})}})}))}}const s=t.getRole();return s&&V.zz(s)?{key:t.id,action:()=>n(t.id),render:e=>d().createElement(de.Z,U()({store:t,hidePath:!1},e))}:void 0}({store:o,alreadySelectedAncestorId:s(o),environment:a,onSelectPage:i})})).filter(k.$K);l=0===e.length?r()(le.Z,{},void 0,r()(ae.Z,{title:r()(b.FormattedMessage,{id:"oauthPageSearchResults.noResults.placeholder",defaultMessage:"No results"})})):function(e){return r()(K.Z,{type:K.Z.Type.Vertical,initialFocus:void 0,sections:[{key:"results",items:e,render:e=>d().createElement(le.Z,e)}]})}(e)}const g={menuType:se.ZP.MenuType.Popup};return d().createElement(se.ZP,g,l)}var he=i(66722);class ge extends E.Z{constructor(){super(...arguments),s()(this,"sidebarState",this.createComputedStore((()=>(0,O.vK)(this.environment)))),s()(this,"storeTypes",{selectedBlockIdsStore:_.Z.of({}),searchStore:_.Z.of({open:!1,query:void 0})}),s()(this,"getPageSection",((e,t,i)=>{const o=i.filter((e=>V.zz(e.getRole()||"none")));return{key:e,render:e=>d().createElement(le.Z,e),items:[this.getPageSectionHeader(t,o),...0===o.length?[this.getEmptyState()]:o.map((e=>this.getPageItem(e,1)))]}})),s()(this,"getPageItem",((e,t)=>{const{selectedBlockIdsStore:i}=this.stores,{device:o}=this.environment,r=i.state[e.id];return{key:e.id,action:()=>this.props.onClickPage(e.id,r),render:i=>d().createElement(te,U()({},i,{isMobile:o.isMobile,store:e,isChecked:r,disabled:!1,nestingLevel:t}))}})),s()(this,"getPageSectionHeader",((e,t)=>{const{selectedBlockIdsStore:i}=this.stores,{device:o}=this.environment,n=t.length>0&&t.every((e=>i.state[e.id]));return{key:e,action:()=>this.props.onClickSection(t),render:t=>d().createElement(H.Z,U()({},t,{title:r()(X.Z,{left:r()(Y.Z,{onClick:t.onClick,checked:n,size:16}),isMobile:o.isMobile,style:this.getSectionHeaderStyle()},void 0,e)}))}})),s()(this,"getEmptyState",(()=>{const{device:e}=this.environment;return{key:"empty",action:()=>{},render:t=>d().createElement(H.Z,U()({},t,{title:r()(X.Z,{isMobile:e.isMobile,style:{fontSize:14,color:this.theme.mediumTextColor,padding:"2px 32px"}},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.selectPageStep.empty",defaultMessage:"No pages inside"}))}))}})),s()(this,"handleSearchQueryChange",(e=>{const t=this.stores.searchStore.state,i=e.length>0;this.stores.searchStore.setState({...t,query:e,open:i})})),s()(this,"handleSearchCancel",(()=>{const e=this.stores.searchStore.state;this.stores.searchStore.setState({...e,open:!1,query:void 0})})),s()(this,"findSelectedBlockAncestorId",(e=>{const{selectedBlockIdsStore:t}=this.stores;if(t.state[e.id])return e.id;const i=j.fJ(e).find((e=>e.table===D.iU&&t.state[e.value.id]));return i?i.value.id:void 0}))}renderComponent(){const{intl:e}=this.props,{searchStore:t,selectedBlockIdsStore:i}=this.stores,{device:o}=this.environment;if(!this.sidebarState.state)return r()(W.Z,{});const{allSharedPagesStores:n,showWorkspaceSection:s,showSharedSection:a,showPrivateSection:l,showOnlyPrivateSection:c}=this.sidebarState.state,{currentSpaceViewStore:g,currentSpaceStore:u}=z.default.state;if(!g||!u)return;const p=g.getWorkspacePages().filter((e=>e.state.value&&"copy_indicator"!==e.state.value.type)),m=g.getPrivatePages(this.environment).filter((e=>e.state.value&&"copy_indicator"!==e.state.value.type)),S=Object.keys(i.state).filter((e=>i.state[e])).map((e=>new q.Z(this.environment,{table:D.iU,id:e}))).filter((e=>{var t;return(null===(t=e.state.value)||void 0===t?void 0:t.space_id)===u.id&&e.isNavigableBlock()&&!e.isTopLevelPrivatePage(u.id,this.environment)&&!e.isTopLevelWorkspacePage(u.id)&&!n.some((t=>t.id===e.id))})),v=(0,I.getSpaceName)(this.environment,u),y=[];if(S.length>0&&y.push({key:"manual",render:e=>d().createElement(le.Z,U()({},e,{title:r()(X.Z,{isMobile:o.isMobile,style:this.getSectionHeaderStyle()},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.selectPagesStep.pagePicker.manuallyAddedPagesSection.title",defaultMessage:"Manually added"})),isTitleUppercase:!0})),items:S.map((e=>this.getPageItem(e,0)))}),s&&y.push(this.getPageSection("workspace",e.formatMessage({id:"oauthAuthorizationPage.selectPagesStep.pagePicker.workspaceSection.title",defaultMessage:"Workspace",description:"This word is used in the same context as the title for the Workspace section of the sidebar."}),p)),a&&y.push(this.getPageSection("shared",e.formatMessage({id:"oauthAuthorizationPage.selectPagesStep.pagePicker.sharedSection.title",defaultMessage:"Shared",description:"This word is used in the same context as the title for the Shared section of the sidebar."}),n)),l){const t=c?v||"":e.formatMessage({id:"oauthAuthorizationPage.selectPagesStep.pagePicker.privateSection.title",defaultMessage:"Private",description:"This word is used in the same context as the title for the Private section of the sidebar."});y.push(this.getPageSection("private",t,m))}return d().createElement(d().Fragment,null,r()(he.GI,{origin:r()(G.Z,{focus:!0,focusAfterAnimation:!0,value:t.state.query||"",onChange:e=>{this.handleSearchQueryChange(e.target.value)},left:h.Z.searchThick(this.getSearchIconStyle()),placeholder:e.formatMessage({id:"oauthAuthorizationPage.selectPagesStep.pagePicker.search.placeholder",defaultMessage:"Search for pages in {workspaceName}"},{workspaceName:v})}),sameWidthAsOrigin:!0,popupType:he.GI.PopupType.Popup,open:t.state.open,render:()=>r()(ce,{spaceId:u.id,onSelectPage:e=>this.props.onClickPage(e,!1),query:t.state.query||"",source:"oauth",findSelectedBlockAncestorId:this.findSelectedBlockAncestorId}),onDismiss:this.handleSearchCancel}),r()("div",{style:this.getPageListStyle()},void 0,r()(K.Z,{type:K.Z.Type.Vertical,sections:y,initialFocus:void 0})))}getSectionHeaderStyle(){return{textTransform:"uppercase",fontSize:12,fontWeight:600,color:this.theme.mediumTextColor,padding:"2px 0"}}getPageListStyle(){return{alignItems:"left",width:"100%",height:380,borderWidth:1,borderStyle:"solid",borderColor:c.ZP.contentBorder,overflowY:"auto"}}getSearchIconStyle(){return{width:14,height:14,marginLeft:8,marginRight:8,flexGrow:0,flexShrink:0,fill:this.theme.mediumIconColor}}}const ue=(0,b.injectIntl)(ge);var pe=i(2297),me=i(37871),Se=i(45094),ve=i(81236),ye=i(17364),fe=i(1101),ke=i(98285),we=i(34011),be=i(31280);class Pe extends be.g6{renderAccountHeader(e){const t=ye.Z.getUserEmailAddress(this.environment,e);return t&&r()(fe.Z,{emailAddress:t,userId:e,disabled:!1,accountActions:[(0,pe.qu)(e)]})}renderFooter(){return r()("div",{style:this.getFooterStyle()},void 0,r()(le.Z,{},void 0,me.k(this.environment)&&d().createElement(ke.Z,U()({createType:"add-account",disableLoginLink:this.props.disableLoginLink},this.stores))))}getMenuListSections(e){const{device:t}=this.environment;return[{key:"spaces",render:e=>d().createElement(le.Z,U()({},e,{disableMobilePadding:!0,topBorder:t.isMobile,style:{borderBottom:"1px solid ".concat(this.theme.regularDividerColor)}})),items:this.getSpaceMenuListItems(e)}]}getSpaceMenuListItems(e){const{onSpaceClick:t}=this.props,i=[],{currentUserRootStore:o,currentSpaceStore:n}=z.default.state,s=ye.Z.getSpaceViewStores(this.environment,e);if(!o||!n)return[];s.sort(((e,t)=>{var i,o;const r=Number(Boolean(null===(i=e.getSpaceStore())||void 0===i?void 0:i.canAdmin()));return Number(Boolean(null===(o=t.getSpaceStore())||void 0===o?void 0:o.canAdmin()))-r}));for(const a of s){const s=a.getSpaceStore();if(s){const l=e===o.id&&s.id===n.id,c=(0,I.getSpaceName)(this.environment,s),h=!s.canRead();let g;const u=ve.Z.getPublicSpaceData(this.environment,s.id);if(u){const e=u.productId?this.props.intl.formatMessage((0,Se.em)(u.productId)):this.props.intl.formatMessage("team"===s.getPlanType()?Se.js.teamTrialPlan:Se.js.personalPlan);g=this.props.intl.formatMessage("personal"===s.getPlanType()?Se.js.workspaceSubtitleWithoutMembers:Se.js.workspaceSubtitleWithMembers,{numberOfWorkspaceMembers:this.props.intl.formatNumber(u.memberCount),planType:e})}i.push({key:a.id,render:e=>d().createElement(we.Z,U()({},e,{id:a.id,icon:(0,I.getSpaceIcon)(this.environment,s),title:c,caption:g,isCheck:l,showDragHandle:!1,disabled:h,disableTooltip:!h,tooltipMessage:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.workspaceSwitcher.disabledWorkspace.tooltip",defaultMessage:"This integration can only be added by a member or admin."})})),action:async e=>{let{event:i}=e;this.close(),l||await t({event:i,spaceViewStore:a})}})}}return i}getUnreadCountForOtherSpaces(){return 0}}const Me=(0,b.injectIntl)(Pe);var Ae=i(47966);class xe extends E.Z{constructor(){super(...arguments),s()(this,"storeTypes",{authorizationStepStore:_.Z.of("permissions"),selectedBlockIdsStore:_.Z.of({}),existingBotStore:_.Z.of(void 0)}),s()(this,"renderErrorOrAuthorizationPage",(()=>{const{responseType:e,integrationId:t}=this.props,{existingBotStore:i}=this.stores,{currentUserRootStore:o,currentSpaceStore:n,currentSpaceViewStore:s,currentUserSettingsStore:a}=z.default.state;if(!(o&&n&&s&&a))return;const d=(0,I.getSpaceName)(this.environment,n);if(!t||!(0,p.e)(t))return this.renderError({type:u._.invalid_request,body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.invalidClientId.body",defaultMessage:"Missing or incomplete Client ID. See <inlinetextlink>developer docs</inlinetextlink> for more help.",values:{inlinetextlink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return r()(L.Z,{href:"https://developers.notion.com/#handling-errors"},void 0,t)}}}),integration:void 0});const l=(0,T.Kv)(o,{table:v.K2,id:t});return l.isReady()?l.state.value?"code"!==e?this.renderError({type:u._.invalid_request,body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.invalidResponseType",defaultMessage:"Missing or invalid response_type. See <inlinetextlink>developer docs</inlinetextlink> for more help.",values:{inlinetextlink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return r()(L.Z,{href:"https://developers.notion.com/#handling-errors"},void 0,t)}},description:"Do not translate 'response_type', it's code."}),integration:l.state.value}):i.state&&i.state.created_by_id!==o.id?this.renderError({type:u._.access_denied,title:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.integrationAlreadyInstalled.title",defaultMessage:"This integration has already been added to {workspaceName}",values:{workspaceName:d}}),body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.integrationAlreadyInstalled.body",defaultMessage:"You can review and remove added integrations in Settings."}),integration:l.state.value,primaryAction:r()(F.Z,{isLarge:!0,onClick:()=>{P.Hx({environment:this.environment,spaceViewStore:s,spaceStore:n,userSettingsStore:a,userRootStore:o})}},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.integrationAlreadyInstalled.openWorkspaceSettingsButton.label",defaultMessage:"Open Settings"}))}):this.renderAuthorizationPage(l.state.value):this.renderError({type:u._.invalid_request,body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.clientNotFound.body",defaultMessage:"Missing or incomplete Client ID. See <inlinetextlink>developer docs</inlinetextlink> for more help.",values:{inlinetextlink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return r()(L.Z,{href:"https://developers.notion.com/#handling-errors"},void 0,t)}}}),integration:l.state.value}):r()(W.Z,{})})),s()(this,"initializeStores",(async()=>{const{selectedBlockIdsStore:e,existingBotStore:t}=this.stores,{currentUserRootStore:i,currentSpaceStore:o}=z.default.state;if(!i||!o)return;await x.bi(this.environment);const{data:r}=N.default.state;if(!r)return;const n=Z.NM(r),s=await this.getExistingBot(n.map((e=>e.botId)));if(!s)return t.reset(),void e.reset();t.setState(s);const a=n.find((e=>e.botId===s.id));a&&e.setState(a.pageIds.reduce(((e,t)=>(e[t]=!0,e)),{}))})),s()(this,"getExistingBot",(async e=>{const{integrationId:t}=this.props,{currentUserRootStore:i,currentSpaceStore:o}=z.default.state;if(!i||!o)return;return(await Promise.all(e.map((async e=>{const t=(0,T.Kv)(i,{table:S.c,id:e,spaceId:o.id});return await t.load(),t.getValue()})))).find((e=>e&&e.alive&&(0,l.oA)(e)&&e.parent_id===i.id&&e.integration_id===t))})),s()(this,"switchToPagePickerStep",(()=>{this.stores.authorizationStepStore.setState("page_picker")})),s()(this,"switchToPermissionsStep",(()=>{this.stores.authorizationStepStore.setState("permissions")})),s()(this,"handleSpaceSwitch",(async e=>{const{spaceViewStore:t}=e;await A.ce({environment:this.environment,spaceViewStore:t}),await this.initializeStores()})),s()(this,"handleCancel",(e=>{P.VW({environment:this.environment,params:this.props,integration:e,errorType:u._.access_denied})})),s()(this,"handleAuthorize",((e,t)=>{const{selectedBlockIdsStore:i}=this.stores;P.VW({environment:this.environment,params:this.props,integration:e,spaceId:t,blockIdsForBot:Object.keys(i.state).filter((e=>i.state[e]))})})),s()(this,"handleClickPage",((e,t)=>{const{selectedBlockIdsStore:i}=this.stores;i.setState({...i.state,[e]:!t})})),s()(this,"handleClickSection",(e=>{const{selectedBlockIdsStore:t}=this.stores,i=e.every((e=>t.state[e.id]));t.setState({...t.state,...e.reduce(((e,t)=>(e[t.id]=!i,e)),{})})}))}willMount(){const{responseType:e,integrationId:t,redirectUri:i,state:o,owner:r}=this.props;y.setOauthAuthorizationParams({responseType:e,integrationId:t,redirectUri:i,state:o,owner:r})}async didMount(){const{currentSpaceStore:e,currentSpaceViewStore:t}=z.default.state;e&&t&&e.canAdmin()?await this.initializeStores():await this.setCurrentSpaceToFirstAdminSpace()}renderComponent(){const{currentSpaceStore:e}=z.default.state;if(e)return r()("div",{style:this.getLayoutContainerStyle()},void 0,r()("div",{style:this.getPageContainerStyle()},void 0,r()("div",{style:this.getContentBoxStyle()},void 0,this.renderTopbar(),r()("div",{style:this.getContentBodyStyle()},void 0,this.renderErrorOrAuthorizationPage()))))}renderAuthorizationPage(e){const{redirectUri:t}=this.props,{authorizationStepStore:i}=this.stores,{currentSpaceStore:o,currentSpaceViewStore:n}=z.default.state;if(!o||!n)return;const s=(0,I.getSpaceName)(this.environment,o);return o.state.value&&o.canRead()?o.canAdmin()||this.isIntegrationAllowedByAdmin(e)?g._(e,t)?"permissions"===i.state?this.renderPermissionsStep(e,o):"page_picker"===i.state?this.renderPagePickerStep(e,o):(0,k.t1)(i.state):this.renderError({type:u._.invalid_request,body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.invalidRedirectUri.body",defaultMessage:"Missing or invalid redirect_uri. See <inlinetextlink>developer docs</inlinetextlink> for more help.",values:{inlinetextlink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return r()(L.Z,{href:"https://developers.notion.com/#handling-errors"},void 0,t)}},description:"Do not translate 'redirect_uri', it's code."}),integration:e}):this.renderError({type:u._.access_denied,title:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.integrationNotApproved.title",defaultMessage:'You are not permitted to add the integration "{integrationName}" to {workspaceName}',values:{integrationName:e.name,workspaceName:s}}),body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.integrationNotApproved.body",defaultMessage:"Contact your system administrator for more information."}),integration:e,primaryAction:r()(F.Z,{isLarge:!0,onClick:()=>B.Z.setState({...B.Z.state,open:!0})},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.notAnAdmin.switchWorkspaceButton.label",defaultMessage:"Switch workspace"}))}):this.renderError({type:u._.access_denied,title:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.notAnAdmin.title",defaultMessage:"You're not allowed to add integrations to {workspaceName}",values:{workspaceName:s}}),body:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.notAnAdmin.body",defaultMessage:"Contact an admin to grant you access, or switch to another workspace."}),integration:e,primaryAction:r()(F.Z,{isLarge:!0,onClick:()=>B.Z.setState({...B.Z.state,open:!0})},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.notAnAdmin.switchWorkspaceButton.label",defaultMessage:"Switch workspace"}))})}renderPermissionsStep(e,t){var i,o,n,s,a,l,c,g=this;const u=(0,I.getSpaceName)(this.environment,t),p=e.info.website_url,m=e.info.terms_of_use_url,S=e.info.privacy_policy_url,y=e.info.icon?{pointer:{table:v.K2,id:e.id},icon:e.info.icon}:void 0,f=this.props.redirectUri?this.props.redirectUri.replace("http://","").replace("https://","").split(/[/?#]/)[0]:void 0;return d().createElement(d().Fragment,null,r()("div",{style:{padding:15}},void 0,r()(Q.Z,{icon:y,disabled:!0,title:e.name,size:54,isEmptyPage:!1,style:{margin:"auto"}})),r()("div",{style:this.getTitleStyle()},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.title",defaultMessage:"<inlinetextlink>{integrationName}</inlinetextlink> wants to access {workspaceName}",values:{integrationName:e.name,workspaceName:u,inlinetextlink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return p?r()(L.Z,{style:{...g.getInlineTextLinkStyle(),fontWeight:w.Z.fontWeight.semibold},href:p},void 0,t):t}}})),r()("div",{style:{marginBottom:8}},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.intro",defaultMessage:"<inlinetextlink>{integrationName}</inlinetextlink> wants to",values:{integrationName:e.name,inlinetextlink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return p?r()(L.Z,{href:p,style:g.getInlineTextLinkStyle()},void 0,t):t}}})),(null===(i=e.capabilities)||void 0===i?void 0:i.read_content)&&r()(Ie,{icon:h.Z.eye,title:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.readContent",defaultMessage:"View pages you select",description:"This is one of the things an integration can do once it's added to a user's workspace."})},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.readContent.description",defaultMessage:'"{integrationName}" will be able to view pages you select in the next step. You can also share pages later with "{integrationName}" via the Share menu.',values:{integrationName:e.name,workspaceName:u}})),(null===(o=e.capabilities)||void 0===o?void 0:o.update_content)&&r()(Ie,{icon:h.Z.pencil,title:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.updateContent",defaultMessage:"Edit pages you select",description:"This is one of the things an integration can do once it's added to a user's workspace."})},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.updateContent.description",defaultMessage:'"{integrationName}" will be able to edit pages you select in the next step. You can also share pages later with "{integrationName}" via the Share menu.',values:{integrationName:e.name,workspaceName:u}})),(null===(n=e.capabilities)||void 0===n?void 0:n.insert_content)&&r()(Ie,{icon:h.Z.plus,title:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.insertContent",defaultMessage:"Create new content within pages you select",description:"This is one of the things an integration can do once it's added to a user's workspace."})},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.insertContent.description",defaultMessage:'"{integrationName}" will be able to add new content or sub-pages to pages you select in the next step. You can also share pages later with "{integrationName}" via the Share menu.',values:{integrationName:e.name,workspaceName:u}})),((null===(s=e.capabilities)||void 0===s?void 0:s.read_user_without_email)||(null===(a=e.capabilities)||void 0===a?void 0:a.read_user_with_email))&&r()(Ie,{icon:h.Z.settingsMembers,title:null!==(l=e.capabilities)&&void 0!==l&&l.read_user_with_email?r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.viewUsersAndEmail",defaultMessage:"View workspace users and their emails",description:"This is one of the things an integration can do once it's added to a user's workspace."}):r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.viewUsers",defaultMessage:"View workspace users",description:"This is one of the things an integration can do once it's added to a user's workspace."})},void 0,null!==(c=e.capabilities)&&void 0!==c&&c.read_user_with_email?r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.viewUsersAndEmail.detail",defaultMessage:'"{integrationName}" will be able to see basic information about all workspace members and guest data, including their names, profile images, and email addresses.',values:{integrationName:e.name}}):r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.permissionListItem.viewUsers.detail",defaultMessage:'"{integrationName}" will be able to see basic information about all workspace members and guests, like their names and profile images, but not their email addresses.',values:{integrationName:e.name}})),this.renderOptionButtons({leftText:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.cancelButton.label",defaultMessage:"Cancel"}),leftAction:()=>this.handleCancel(e),rightText:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.continueButton.label",defaultMessage:"Select pages",description:"This button will take a user to a screen where they can choose pages to share with an integration."}),rightAction:this.switchToPagePickerStep}),r()("div",{style:{display:"flex",alignItems:"center",marginTop:20}},void 0,t.canAdmin()&&!this.isIntegrationAllowedByAdmin(e)&&r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.integrationApprovalNotice",defaultMessage:"Authorizing this integration will add it to your workspace's approval list. Other workspace members will be able to install this integration."})),r()("footer",{style:this.getFooterStyle()},void 0,r()("div",{style:{color:this.theme.regularTextColor,fontWeight:w.Z.fontWeight.semibold,marginBottom:4}},void 0," ",r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.warning.title",defaultMessage:'Make sure you trust "{integrationName}" ({redirectUriDomain})',values:{integrationName:e.name,redirectUriDomain:f}})),r()("div",{},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.permissionStep.warning.body",defaultMessage:'If you continue, you may be sharing sensitive information. Notion does not review third party integrations such as "{integrationName}". Learn how "{integrationName}" handles your data by reviewing their <privacypolicylink>Privacy Policy</privacypolicylink> and <termsofservicelink>Terms of Service</termsofservicelink>.',values:{integrationName:e.name,privacypolicylink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return S?r()(L.Z,{href:S},void 0,t):t},termsofservicelink:function(){for(var e=arguments.length,t=new Array(e),i=0;i<e;i++)t[i]=arguments[i];return m?r()(L.Z,{href:m},void 0,t):t}}}))))}renderPagePickerStep(e,t){return d().createElement(d().Fragment,null,r()("div",{style:this.getSubtitleStyle()},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.selectPagesStep.title",defaultMessage:'Allow "{integrationName}" to access these pages',values:{integrationName:e.name}})),r()(ue,{onClickPage:this.handleClickPage,onClickSection:this.handleClickSection,selectedBlockIdsStore:this.stores.selectedBlockIdsStore}),this.renderOptionButtons({leftText:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.selectPagesStep.backButton.label",defaultMessage:"Back"}),leftAction:this.switchToPermissionsStep,rightText:r()(b.FormattedMessage,{id:"oauthAuthorizationPage.selectPagesStep.finishButton.label",defaultMessage:"Allow access",description:"This button, once clicked, adds an integration to a user's workspace and automatically gives it access to a set of pages the user selected."}),rightAction:()=>this.handleAuthorize(e,t.id)}))}renderTopbar(){const{isMobile:e}=this.environment.device;return r()("div",{style:{display:"flex",alignItems:"center",justifyContent:"space-between",height:60,paddingLeft:20,paddingRight:8,borderBottomWidth:1,borderBottomStyle:"solid",borderBottomColor:c.ZP.contentBorder}},void 0,h.Z.notionLogoStroked({width:e?28:30,height:e?28:30,marginRight:10,flexShrink:0}),r()("div",{style:{fontWeight:w.Z.fontWeight.medium,fontSize:16}},void 0,"Notion"),r()("div",{style:{flexGrow:1,flexShrink:1}}),r()("div",{style:{flexShrink:0}},void 0,r()(Me,{format:be._S.Regular,onSpaceClick:e=>{let{spaceViewStore:t}=e;return this.handleSpaceSwitch({spaceViewStore:t})},shouldShowUnexpandButton:!1,disableLoginLink:!0,buttonStyle:{borderRadius:3,marginBottom:0}})))}renderOptionButtons(e){return r()("div",{style:this.getButtonGroupStyle()},void 0,r()(Ae.Z,{isLarge:!0,onClick:e.leftAction,style:{height:32}},void 0,e.leftText),r()(F.Z,{isLarge:!0,onClick:e.rightAction},void 0,e.rightText))}renderError(e){let{integration:t,type:i,title:o,body:n,primaryAction:s}=e;const a=o||r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.genericError.title",defaultMessage:"Something went wrong"});return r()("section",{style:this.getErrorContainerStyle()},void 0,h.Z.genericError(this.getErrorIconStyle()),r()("header",{style:{...this.getTitleStyle(),marginBottom:12}},void 0,a),n&&r()("p",{style:this.getErrorBodyStyle()},void 0,n),s&&r()("div",{style:this.getErrorBodyStyle()},void 0,s),r()(Ae.Z,{onClick:()=>{P.VW({environment:this.environment,integration:t,errorType:i,params:this.props})}},void 0,r()(b.FormattedMessage,{id:"oauthAuthorizationPage.error.cancelButton.label",defaultMessage:"Cancel"})))}get isOauthDisabledByAdmin(){const{currentSpaceStore:e}=z.default.state;if(!e||!e.state.value)return!1;return(0,f.xI)(e.state.value).disablePersonalBots}isIntegrationAllowedByAdmin(e){const{currentSpaceStore:t}=z.default.state;if(!t||!t.state.value)return!1;const i=t.state.value.bot_settings;if(!i)return!0;if((0,f.CJ)(i)){const t=i.integration_approval_statuses;return!(!t||!t[e.id])&&Boolean("approved"===t[e.id].status)}return!0}async setCurrentSpaceToFirstAdminSpace(){const{currentUserRootStore:e}=z.default.state;if(e){const t=e.getSpaceViewStores();if(t.length>0){const e=t.find((e=>e.canAdmin()));return void(await this.handleSpaceSwitch({spaceViewStore:e||t[0]}))}}M.navigate({environment:this.environment,url:m._j.login,redirect:!0})}getLayoutContainerStyle(){const{WindowSizeStore:e}=this.environment;return{height:"100%",overflow:"auto",backgroundColor:e.state.width>500?c.ZP.frontCreamBackground:c.ZP.white}}getPageContainerStyle(){return{display:"flex",justifyContent:"center"}}getContentBoxStyle(){const{WindowSizeStore:e}=this.environment,t=e.state.width>500,i=e.state.height<600?16:t?"calc((100vh - 600px) / 2)":0,o=t?this.theme.lightBoxShadow:"none";return{width:"500px",minHeight:"600px",borderRadius:5,backgroundColor:c.ZP.white,boxShadow:o,display:"flex",flexDirection:"column",fontSize:w.Z.fontSize.UIRegular.desktop,marginTop:i,transition:"all 0.2s ease"}}getContentBodyStyle(){return{paddingLeft:40,paddingRight:40,paddingTop:25,paddingBottom:25,flex:1,display:"flex",flexDirection:"column"}}getFooterStyle(){return{fontSize:w.Z.fontSize.UISmall.desktop,color:this.theme.mediumTextColor,paddingTop:32,paddingBottom:16}}getTitleStyle(){const{device:e}=this.environment;return{fontSize:e.isMobile?18:20,margin:"0 50px 32px",textAlign:"center",fontWeight:w.Z.fontWeight.medium}}getSubtitleStyle(){return{fontSize:14,textAlign:"center",fontWeight:w.Z.fontWeight.medium,marginBottom:16}}getButtonGroupStyle(){return{display:"grid",gridTemplateColumns:"1fr 1fr",gap:8,marginTop:24}}getErrorContainerStyle(){return{textAlign:"center",flex:1,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center"}}getErrorIconStyle(){const{device:e}=this.environment,t=e.isMobile?25:48;return{fill:c.ZP.red,width:t,height:t,marginBottom:20,display:"inline-block"}}getErrorBodyStyle(){return{marginTop:0,marginBottom:24,width:"80%"}}getInlineTextLinkStyle(){return{borderBottom:"1px solid rgba(54, 53, 47, 0.2)",color:"black",textDecoration:"none"}}}function Ie(e){const[t,i]=(0,a.useState)(!1),o=(0,C.y)((e=>({permissionItem:{display:"flex",justifyContent:"space-between",padding:"6px 0",cursor:"pointer",userSelect:"none"},permissionItemHeading:{display:"flex",alignItems:"center"},permissionItemDetails:{paddingLeft:32,transition:"all 0.2s ease",color:e.mediumTextColor},rightStyle:{width:22,height:18},sharedIconStyle:{width:24,height:16,textAlign:"center",marginRight:8}})),[]);return d().createElement(d().Fragment,null,r()("div",{style:o.permissionItem,onClick:()=>i(!t)},void 0,r()("div",{style:o.permissionItemHeading},void 0,r()("div",{style:o.sharedIconStyle},void 0,e.icon({width:16,height:16,color:c.ZP.regularIconColor})),r()("div",{},void 0,e.title)),e.children&&r()("div",{},void 0,h.Z.chevronDownThin({width:12,height:12,color:c.ZP.lightIconColor,transform:t?"rotate(180deg)":void 0,transition:"transform 0.2s ease"}))),r()("div",{style:{...o.permissionItemDetails,opacity:t?1:0,flex:t?1:0,paddingBottom:t?8:0,transform:t?"translate3d(0,-4px,0)":"translate3d(0,-8px,0)"}},void 0,t&&e.children))}const Ze=(0,b.injectIntl)(xe)}}]);