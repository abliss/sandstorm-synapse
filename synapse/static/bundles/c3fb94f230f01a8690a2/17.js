(window.webpackJsonp=window.webpackJsonp||[]).push([[17],{1582:function(e,t,n){"use strict";n.r(t),n.d(t,"default",(function(){return m}));var a=n(5),s=n.n(a),o=n(0),i=n.n(o),c=n(2),r=n.n(c),l=n(3),u=n(4),p=n(6),d=n(1),h=n(9);class m extends i.a.PureComponent{constructor(...e){super(...e),s()(this,"onOkClick",()=>{this.props.onFinished()}),s()(this,"onGoToSettingsClick",()=>{this.props.onFinished(),p.a.dispatch({action:"view_user_settings"})}),s()(this,"onSetupClick",async()=>{const e=l.a("dialogs.keybackup.RestoreKeyBackupDialog");h.a.createTrackedDialog("Restore Backup","",e,{onFinished:this.props.onFinished},null,!1,!0)})}render(){const e=l.a("views.dialogs.BaseDialog"),t=l.a("views.elements.DialogButtons"),n=i.a.createElement("span",{className:"mx_KeyBackupFailedDialog_title"},Object(d.a)("New Recovery Method")),a=i.a.createElement("p",null,Object(d.a)("A new recovery passphrase and key for Secure Messages have been detected.")),s=i.a.createElement("p",{className:"warning"},Object(d.a)("If you didn't set the new recovery method, an attacker may be trying to access your account. Change your account password and set a new recovery method immediately in Settings."));let o;return o=u.a.get().getKeyBackupEnabled()?i.a.createElement("div",null,a,i.a.createElement("p",null,Object(d.a)("This session is encrypting history using the new recovery method.")),s,i.a.createElement(t,{primaryButton:Object(d.a)("OK"),onPrimaryButtonClick:this.onOkClick,cancelButton:Object(d.a)("Go to Settings"),onCancel:this.onGoToSettingsClick})):i.a.createElement("div",null,a,s,i.a.createElement(t,{primaryButton:Object(d.a)("Set up Secure Messages"),onPrimaryButtonClick:this.onSetupClick,cancelButton:Object(d.a)("Go to Settings"),onCancel:this.onGoToSettingsClick})),i.a.createElement(e,{className:"mx_KeyBackupFailedDialog",onFinished:this.props.onFinished,title:n},o)}}s()(m,"propTypes",{newVersionInfo:r.a.object,onFinished:r.a.func.isRequired})}}]);