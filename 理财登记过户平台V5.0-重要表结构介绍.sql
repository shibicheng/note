-- 菜单相关表
select * from tsys_menu;
select * from tsys_trans;
select * from tsys_subtrans;

-- 节点或者交易相关表
select * from tbtaskpool;
select * from tbnodepool;
select * from tbtrans;

-- 密码复杂度设置
select * from tsys_parameter;

-- 系统参数表
select * from tbparam;
select * from tbdict where hs_key='K_FELB';
select * from tsys_dict_entry where dict_entry_code='K_FELB';
select * from tsys_dict_item where dict_entry_code='K_FELB';

-- 系统参数
select * from tbsysarg;

-- 1.产品信息设置相关表 
select * from tbprdtemplate;  -- 产品模板表
select * from tbelementgroup; -- 页面元素分组表
select * from tbtemplaterelgroup; -- 模板元素分组关系表 
select * from tbpageelement ; -- 产品页面元素表
select * from tbdataelement;  -- 数据元素表
select * from tbcontrolflagdesc; --  控制字段描述表
select * from tbdict where hs_key='K_CPLX';
select * from tbproduct;
select * from tbprdextend;  -- 产品信息扩展字段的保存
select * from tbproductext; -- 扩展表用于一些临时用法，日志601100节点会生成

-- 2. 接受文件相关表
select * from tbmultbatchfile;  -- 多批次文件交互表
select * from tbsellerfileinfo; -- 销售商文件信息表 读文件的时候会和这个表记录的信息比较

-- 3.读文件导文件相关配置表
select * from tbbankta;  -- 假如601102节点报错，需要重导文件的操作时，这个时候就需要调整tbbankta的状态为0
select * from tbsellerfiletype where seller_code='S00' and file_dir='2' and file_type='02' order by file_dir;
select * from tbtadict where templet='BZD21';
select * from tbfieldmap where templet='BZD21' and file_type='02';
select * from tbdictmap  where templet='BZD21'; -- direction 0-导出 1-导入
select * from tbbusincodechg where busin_code='02'; -- 业务码转换表
select * from tbbusincodechg where busin_name like '%冻结';

-- 4.跑批过程中临时表使用
select * from tbtaaccreq00;      -- ta账户类申请临时表
select * from tbtaacccfm00;      -- ta账户类确认临时表
select * from tbtatransreq00;    -- ta交易申请清算临时表  导入文件的时候会记录客户姓名到reserve3字段 如果数据移植需要注意
select * from tbtatranscfm00 ;    -- ta交易确认清算临时表  同样的生成的确认流水reserve3字段也是客户姓名 如果数据移植需要注意
select * from tbtadivdetail00 ;   -- Ta分红清算临时表
select * from tbfrozendetail00 ;  -- Ta冻结清算临时表
select * from tbincome00  ;       -- Ta收益分配临时表
select * from tbsharechg100 ;     -- ta份额变动表
select * from tbtacfmdetail00 ;   -- ta交易类确认明细临时表

-- 5.601100节点 片区会清理临时表的数据
-- 6.601258节点 会统计当日的产品交易类型数据到 tbprdbusinsum表
select * from tbprdbusinsum;

-- 7.601103节点进行开户处理
select * from tbclient;
select * from tbclientseller;
select * from tbassetacc; -- 销售商下首卡记录及000默认
select * from tbtatransaccount; -- 交易账户全的记录
select * from tbinstinfo;  -- 机构客户

-- 8.200547净值导入
select * from tbprddaily; 

-- 9.601101生成tbtabatch
select * from tbtabatchdetail;
select * from tbtabatch where trans_code='601217';

-- 10.601238主要进行超额申购巨额赎回的控制
select * from tbprddaily ; -- larg_red_flag larg_red_cfm_rate excess_cfm_rate excess_flag; 

-- 11.601209份额冻结解冻
select * from tbtatransreq00 where busin_code='10';
select * from tbtatranscfm00 where busin_code='10';
select * from tbfrozendetail00; -- frozen_type(0：账户冻结 1：份额冻结) frozen_flag(frozen_flag)
select * from tbshare1-16;  -- 份额冻结会记录long_frozen_vol

-- 12 .601214 变更分红方式处理的是share表的div_mode

-- 13. 非交易过户及快赎
select * from tbtatransreq00 where busin_code ='12' and out_busin_code='098';
select * from tbtatranscfm00 where busin_code in ('12','14','15'); 
select * from tbadvanceaccount;
select * from tbadvanceamt;

-- 14.分红处理
select * from tbprofitschema;
select * from tbprofitschemaext;

-- 部分本金返还
select * from tbreturnset;  -- reserve2 片区返还金额 reserve3片区返还份额

-- 15.收益分配
select * from tbproductext; -- reservee5 份额 、reserve6 收益
select * from tbincome00; 
select * from tbshare1-16;  -- income_frozen income_onway income_new tot_income reserve3 last_date

-- 16：收益结转
select * from tbtadivdetail00;
select * from tbshare1-16;

-- 17: 认购确认
select * from tbtatransreq00;
select * from tbtatranscfm00;
select * from tbissuegroup;  
-- 17:申购确认
select * from tbtatranscfm00 ;  -- cfm_amt包含手续费  ch_vol保存本金
select * from tbshare1-16;  		    -- cost 字段保存本金
select * from vsharedetail;		  -- cost 保存本金 source_flag(K_FELY 份额来源)
select * from tbsharechg100;    -- 份额变动表

-- 18:赎回确认
select * from tbtatransreq00 where busin_code='03' and red_mode='4';
select * from tbtatranscfm00 ;  -- cfm_amt不包含手续费  
select * from tbtacfmdetail00;
select * from tbshare1-16;  		    -- 赎回不减本金字段
select * from vsharedetail;		  -- 会处理manage_fee和manage_date
select * from tbsharechg100;    -- 份额变动表
select * from tbbenchmarkset;   -- 业绩基准
select * from tbrewardset;			-- 超额报酬比例
select * from tbpriceset;				-- 产品收益率设置表

-- 19:产品成立601227
select * from tbtatranscfm00 where busin_code in ('50','54');
select * from tbproduct  where ; -- real_estab_date 成立后>0  发行失败issue_fail_date记录 状态为3 
select * from tbissuegroup; -- 去更新allot_rate 根据这个来成立确认

-- 20:产品到期
select * from tbproduct  ; -- 状态为a

-- 21：销户处理
select *  from tbtatransaccount；  -- 删掉
select *  from tbclientseller; -- 状态为1
select *  from tbassetacc;		-- 状态为X 对应销售商那条

-- 22：资金划拨 根据tbtatranscfmsum(601113统计)表数据生成tbfinatransferdetail和tbrealautotransfer

-- 23：资管数据导出
select * from tbbtaallotfiletmp; tbbtaallotfilehis
select * from tbbtaredeemfiletmp;
select * from tbbtabonusfiletmp;
select * from tbbtachargefiletmp;
-- 24：601237 bta清算结束 --临时表数据到正式表

-- 25: 解冻扣款失败处理
select * from tbsellerdedufaildetail;
select * from tbsellerdedufail;
select * from tbdedufaildealreq;
select * from tbtatranscfm;
select * from tbdeductfailcfmexp;

